From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 16:16:26 +0000
Subject: [PATCH] Generic CPU save/restore PM support
Message-ID: <20110211161626.GA31356@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series implements infrastructure to save/restore
CPU state on suspend/resume PM events, and updates SA11x0, PXA and
Samsung platforms to use this.

Only only ARM920, ARM926, SA11x0, XScale, XScale3, V6 and V7 CPUs are
supported.

I've build-tested this for Assabet, PXA, and S3C2410, and boot tested
on Assabet.

Please send your acks/tested bys etc.
