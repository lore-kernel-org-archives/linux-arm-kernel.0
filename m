From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jun 2012 11:45:27 +0100
Subject: [CFT] PL08x patches
In-Reply-To: <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Message-ID: <20120607104527.GA15973@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the PL08x patches.

 drivers/dma/Kconfig        |    1 +
 drivers/dma/amba-pl08x.c   |  941 ++++++++++++++++++++++----------------------
 include/linux/amba/pl08x.h |  156 +-------
 3 files changed, 482 insertions(+), 616 deletions(-)
