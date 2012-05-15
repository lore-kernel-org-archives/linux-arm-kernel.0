From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 May 2012 17:11:36 +0900
Subject: [GIT PULL] cleanup samsung plat-s3c24xx and s5p for v3.5
In-Reply-To: <201205141917.35692.arnd@arndb.de>
References: <4FAEEFD3.9040907@samsung.com>
 <CAOesGMgk+-cqmDmhsjM9fhRpwxV4jNf4y+z1AKWpu8a=6wqkCw@mail.gmail.com>
 <064c01cd31a4$9ddd5c60$d9981520$%kim@samsung.com>
 <201205141917.35692.arnd@arndb.de>
Message-ID: <07f201cd3272$595ba050$0c12e0f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 14 May 2012, Kukjin Kim wrote:
> > It is next/cleanup-samsung-iommu branch and already included in
> > next/cleanup-plat-s3c24xx branch as a base because as I said, that is needed
> > to remove plat-s5p directory.
> > So in this case, would be better if you could pull following branch before
> > pulling next/cleanup-plat-s3c24xx-s5p and sorry for missing pull request it.
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/cleanup-samsung-iommu
> >
> > If any problems, please let me know.
> 
First of all, thanks for your pulling.

> I've pulled the next/cleanup-samsung-iommu into next/drivers and the

But I think would be better if you could pull the next/devel-samsung-iommu into next/drivers instead of next/cleanup-samsung-iommu.
Because actual iommu driver is included in next/devel-samsung-iommu branch and the next/cleanup-samsung-iommu branch includes just
cleanup current Samsung iommu driver.

> next/cleanup-plat-s3c24xx-s5p branch into next/cleanup2, which creates
> a new dependency between our two branches in arm-soc.
> 
Sorry for creating a new dependency :( But now, it is needed and looks ok to me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
