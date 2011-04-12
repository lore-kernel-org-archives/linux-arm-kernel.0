From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Apr 2011 00:32:58 +0530
Subject: [Q] GIC : IRQ_TYPE_LEVEL_LOW interrupts
Message-ID: <4DA4A1E2.9090304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin,

As part of the commit 5c0c1f08a (gic: implement set_type)
change, I see that you are ignoring interrupts which
are of LOW_LEVEL type. Why is that ?

There are interrupts of LOW_LEVEL type on OMAP and this
change break those.

Regards
Santosh
