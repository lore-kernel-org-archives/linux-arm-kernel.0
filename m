From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 13:23:32 +0000
Subject: [PATCH 0/7] ARM: S5P: moving plat-s5p stuff into plat-samsung
In-Reply-To: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
References: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <201204191323.32301.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 April 2012, Kukjin Kim wrote:
> This patches move plat-s5p stuff into plat-samsung for keep just one
> plat directory, plat-samsung for Samsung stuff. Actually, it includes
> small things for common s5p and there is no problem this moving.
> Of course, I'm working on removing plat-s3c24xx and will be submitted
> before v3.4 release.
> 
> NOTE, now the plat-s5p directory which is including Kconfig and dummy
> Makefile is not removed yet because need to cleanup CONFIG_PLAT_S5P
> and will be removed soon.
> 

Very nice!

Out of curiosity, how far are you planning to take the consolidation
of the various directories in the end?
I assume all the s3c24* directories end up getting merged into
s3c24xx, but what about s3c64xx, s5p64x0, s5pc100 and s5pcv210?
Are they going to stay separate or do they get merged together
or with exynos?

	Arnd
