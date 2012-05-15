From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 14:45:50 +0000
Subject: [GIT PULL] cleanup samsung plat-s3c24xx and s5p for v3.5
In-Reply-To: <07f201cd3272$595ba050$0c12e0f0$%kim@samsung.com>
References: <4FAEEFD3.9040907@samsung.com> <201205141917.35692.arnd@arndb.de>
 <07f201cd3272$595ba050$0c12e0f0$%kim@samsung.com>
Message-ID: <201205151445.50516.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Kukjin Kim wrote:
> > I've pulled the next/cleanup-samsung-iommu into next/drivers and the
> 
> But I think would be better if you could pull the next/devel-samsung-iommu into next/drivers instead of next/cleanup-samsung-iommu.
> Because actual iommu driver is included in next/devel-samsung-iommu branch and the next/cleanup-samsung-iommu branch includes just
> cleanup current Samsung iommu driver.

Ah, right. I though this was going through J?rg's IOMMU tree, but I saw now
that he agreed to having the new driver merged through arm-soc.

I've pulled both branches into next/drivers now.

	Arnd
