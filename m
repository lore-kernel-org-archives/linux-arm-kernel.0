From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 19:17:35 +0000
Subject: [GIT PULL] cleanup samsung plat-s3c24xx and s5p for v3.5
In-Reply-To: <064c01cd31a4$9ddd5c60$d9981520$%kim@samsung.com>
References: <4FAEEFD3.9040907@samsung.com>
 <CAOesGMgk+-cqmDmhsjM9fhRpwxV4jNf4y+z1AKWpu8a=6wqkCw@mail.gmail.com>
 <064c01cd31a4$9ddd5c60$d9981520$%kim@samsung.com>
Message-ID: <201205141917.35692.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Kukjin Kim wrote:
> It is next/cleanup-samsung-iommu branch and already included in
> next/cleanup-plat-s3c24xx branch as a base because as I said, that is needed
> to remove plat-s5p directory.
> So in this case, would be better if you could pull following branch before
> pulling next/cleanup-plat-s3c24xx-s5p and sorry for missing pull request it.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/cleanup-samsung-iommu
> 
> If any problems, please let me know.

I've pulled the next/cleanup-samsung-iommu into next/drivers and the 
next/cleanup-plat-s3c24xx-s5p branch into next/cleanup2, which creates
a new dependency between our two branches in arm-soc.

	Arnd
