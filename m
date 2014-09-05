From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Sep 2014 10:40:56 +0100
Subject: [PATCH FYI 0/4] FIQ-based backtracing support
Message-ID: <20140905094056.GD30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a prototype series for FIQ backtracing support, which is most
useful when trying to debug things like a spinlock lockup on a SMP
system, or a deadlock inside an IRQs-off region.

Some of this is based upon work by Daniel Thompson and others.

This is a work in progress - especially the final patch.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
