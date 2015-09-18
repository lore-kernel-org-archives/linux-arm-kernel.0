From: davem@davemloft.net (David Miller)
Date: Fri, 18 Sep 2015 10:09:52 -0700 (PDT)
Subject: [PATCH] iommu-common: only compile lib/iommu_common.c for Sparc64
In-Reply-To: <55FBD36C.5070301@arm.com>
References: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
 <20150917.113806.1491126940106627619.davem@davemloft.net>
 <55FBD36C.5070301@arm.com>
Message-ID: <20150918.100952.975850165461332930.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 18 Sep 2015 10:03:40 +0100

> Or do you know of a simpler way to fixing it properly which could make
> it still into 4.3?

All I worry about is that if you take it out of the build, doing
the proper fix will suddenly become very low priority and be
forgotten about completely.

Whereas if it actually blocks the build for someone, it's a high
priority issue to address.
