From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Feb 2011 19:11:17 +0000
Subject: [RFC] Generic CPU save/restore PM support
Message-ID: <20110206191117.GA17808@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series implements infrastructure to save/restore
CPU state on suspend/resume PM events, and updates SA11x0, PXA and
Samsung platforms to use this.

Not all CPU support files are updated with the necessary changes -
currently only ARM920, ARM926, SA11x0, XScale, XScale3, V6 and V7
CPUs are supported.

I've build-tested this for Assabet, PXA, and S3C2410, but not boot
tested it yet.
