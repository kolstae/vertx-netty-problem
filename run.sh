#!/usr/bin/env bash

M2=$HOME/.m2
VX=$M2/repository/io/vertx
VX_V=4.0.3
NY=$M2/repository/io/netty

for v in 4.1.6{0..3}.Final; do
  NY_V=$v
  echo With netty $NY_V
  CP=target/classes:$VX/vertx-web/$VX_V/vertx-web-$VX_V.jar:$VX/vertx-web-common/$VX_V/vertx-web-common-$VX_V.jar:$VX/vertx-auth-common/$VX_V/vertx-auth-common-$VX_V.jar:$VX/vertx-bridge-common/$VX_V/vertx-bridge-common-$VX_V.jar:$VX/vertx-core/$VX_V/vertx-core-$VX_V.jar:$VX/vertx-web-client/$VX_V/vertx-web-client-$VX_V.jar
  CP=$CP:$NY/netty-common/$NY_V/netty-common-$NY_V.jar:$NY/netty-buffer/$NY_V/netty-buffer-$NY_V.jar:$NY/netty-transport/$NY_V/netty-transport-$NY_V.jar:$NY/netty-handler/$NY_V/netty-handler-$NY_V.jar:$NY/netty-codec/$NY_V/netty-codec-$NY_V.jar:$NY/netty-handler-proxy/$NY_V/netty-handler-proxy-$NY_V.jar:$NY/netty-codec-socks/$NY_V/netty-codec-socks-$NY_V.jar:$NY/netty-codec-http/$NY_V/netty-codec-http-$NY_V.jar:$NY/netty-codec-http2/$NY_V/netty-codec-http2-$NY_V.jar:$NY/netty-resolver/$NY_V/netty-resolver-$NY_V.jar:$NY/netty-resolver-dns/$NY_V/netty-resolver-dns-$NY_V.jar:$NY/netty-codec-dns/$NY_V/netty-codec-dns-$NY_V.jar
  CP=$CP:$M2/repository/com/fasterxml/jackson/core/jackson-core/2.11.3/jackson-core-2.11.3.jar
  #CP=$CP:$M2/repository/org/jetbrains/kotlin/kotlin-stdlib-jdk8/1.4.32/kotlin-stdlib-jdk8-1.4.32.jar:$M2/repository/org/jetbrains/kotlin/kotlin-stdlib/1.4.32/kotlin-stdlib-1.4.32.jar:$M2/repository/org/jetbrains/kotlin/kotlin-stdlib-common/1.4.32/kotlin-stdlib-common-1.4.32.jar:$M2/repository/org/jetbrains/annotations/13.0/annotations-13.0.jar:$M2/repository/org/jetbrains/kotlin/kotlin-stdlib-jdk7/1.4.32/kotlin-stdlib-jdk7-1.4.32.jar
  java -classpath $CP vertx.repro.App

done
