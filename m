From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Tue, 17 Feb 2015 20:15:27 +0100
Subject: [PATCHv7 0/2] INPUT: Route keyboard LEDs through the generic LEDs
 layer
Message-ID: <20150217191527.GA9594@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is an updated version to fix the initialization of the vt_led_work
queues before registering LEDs, and refresh against 3.19.

Samuel
