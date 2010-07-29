From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 29 Jul 2010 17:46:59 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729084018.GM26098@amd.com>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de> <20100729084018.GM26098@amd.com>
Message-ID: <20100729174621W.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Jul 2010 10:40:19 +0200
"Roedel, Joerg" <Joerg.Roedel@amd.com> wrote:

> The IOMMU-API is not about SR-IOV.

That's true. However, the point is that include/iommu.h is far from
the IOMMU-API.

You could still insist that include/iommu.h is designed for the
generic IOMMU-API. But the fact is that it's designed for very
specific purposes. No intention to make it for generic purposes.

Since you added it two years ago, nobody has tried to extend
it. Instead, we have something like
arch/arm/plat-omap/include/plat/iommu.h.
