From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Dec 2014 17:27:16 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141230162716.GC24811@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

I'm probably getting ahead of myself here, since there has not been
any review comments, but i'm trying to figure out what should be
submitted for -rc3 and which can wait for the next merge window.

[PATCH 1/6] dt: bindings: update mvebu-mbus DT binding with new
branch dt for next merge window, since it is not strictly a fix.

[PATCH 2/6] bus: mvebu-mbus: fix support of MBus window 13
branch fixes for next -rc

[PATCH 3/6] ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada 38x
branch fixes for next -rc

[PATCH 4/6] bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window
branch drivers for next merge window. I assume it is only a run time dependency for the
mv_cesa patches?

[PATCH 5/6] bus: mvebu-mbus: use automatic I/O synchronization barriers
branch fixes for next -rc

[PATCH 6/6] ARM: mvebu: use arm_coherent_dma_ops
Here i'm unsure. Is this a fix, or a cleanup?

Thanks
	Andrew
