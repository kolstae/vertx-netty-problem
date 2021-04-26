package vertx.repro;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Promise;
import io.vertx.core.Vertx;
import io.vertx.core.VertxOptions;
import io.vertx.core.http.HttpServer;
import io.vertx.core.http.HttpServerOptions;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.client.WebClient;
import io.vertx.ext.web.client.WebClientOptions;

public class App {
    public static void main(String[] args) {
        var vertx = Vertx.vertx(new VertxOptions().setPreferNativeTransport(true));
        var verticle = new TestVerticle();
        vertx.deployVerticle(verticle)
                .compose(x ->
                        WebClient.create(vertx, new WebClientOptions().setDefaultHost("localhost").setDefaultPort(verticle.port))
                                .get("/dummy")
                                .send()
                                .onSuccess(response ->
                                        System.out.println("Got response: " + response.statusCode() + " - " + response.bodyAsString())))


                .onComplete(x -> vertx.close());
    }

    static class TestVerticle extends AbstractVerticle {
        private HttpServer server = null;
        int port = 0;

        @Override
        public void start(Promise<Void> startPromise) {
            final Router router = Router.router(vertx);
            router.get("/dummy").handler(ctx -> ctx.response().send("OK"));
            vertx.createHttpServer(new HttpServerOptions().setHost("localhost"))
                    .requestHandler(router)
                    .listen(0)
                    .onComplete(ar -> {
                        if (ar.succeeded()) {
                            server = ar.result();
                            port = server.actualPort();
                            System.out.println("Started server listening on: " + port);
                            startPromise.complete();
                        } else {
                            startPromise.fail(ar.cause());
                        }
                    });
        }

        @Override
        public void stop(Promise<Void> stopPromise) {
            server.close().onComplete(ar -> {
                if (ar.succeeded()) {
                    System.out.println("Stopped server listening on: " + port);
                    stopPromise.complete();
                } else {
                    stopPromise.fail(ar.cause());
                }
            });
        }
    }
}
