From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:22 +0100
Subject: [PATCH v3 0/6] spi: pxa2xx: add slave mode support
Message-ID: <20181113102228.820214-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch set adds slave mode support to pxa2xx.

The objective is that it will be able to support the OLPC XO 1.75 embedded
controller that is a SPI master talking to a MMP2 SOC with an extra
"ready" signal for handshaking.

The patches have been submitted previously along with DT support for the
controller which has already been accepted, hence the "v3". These are
the remaining ones. Reviewed/Ack-ed by tags have been collected. Other
changes to the pataches are described in the respective messages.

The EC driver itself is being reviewed in a separate patch set.
 
Verified on a OLPC XO 1.75 machine.

Thanks to everyone who kindly provided feedback to make the patch set
better.

Thank you,
Lubo
   
