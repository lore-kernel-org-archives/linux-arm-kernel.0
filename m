From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:05:50 +0000
Subject: [PATCH 00/11] PL08x DMA driver updates
Message-ID: <20101224100550.GB20587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an initial set of updates to the PL08x DMA engine driver, which
fixes various problems observed during testing of the PL011 UART driver
on Versatile PB926.

This doesn't include changes necessary to select the appropriate AHB
port, which is platform specific.

Please review and send comments/acks/tested-by's etc.
