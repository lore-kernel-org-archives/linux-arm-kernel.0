From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 28 Feb 2012 22:39:16 +0100
Subject: [PATCH 00/12] ARM: S3C24XX: create mach-s3c24xx/ for S3C24XX SoCs
 - WIP
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <201202282239.17107.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 15 Februar 2012, 23:55:34 schrieb Kukjin Kim:
> This patch aims to make a one mach- directory for S3C24XX SoCs
> and now not finished yet such as moving cpufreq and merging
> plat-s3c24xx/. I think it will be done maybe in a week.
> 
> [PATCH 01/12] ARM: S3C24XX: remove unused spi gpio setup functions
> [PATCH 02/12] ARM: S3C24XX: move spi-s3c24xx platdata out of mach
> [PATCH 03/12] ARM: S3C24XX: Remove extern declaration of clk_msysclk
> [PATCH 04/12] ARM: S3C24XX: move common S3C2443 clock definitions to
> [PATCH 05/12] ARM: S3C2410: move s3c2410_baseclk_add to clock.h
> [PATCH 06/12] ARM: S3C24XX: change the ARCH_S3C2410 to ARCH_S3C24XX
> [PATCH 07/12] ARM: S3C2410: move mach-s3c2410/* into mach-s3c24xx/
> [PATCH 08/12] ARM: S3C2412: move mach-s3c2412/* into mach-s3c24xx/
> [PATCH 09/12] ARM: S3C2416: move mach-s3c2416/* into mach-s3c24xx/
> [PATCH 10/12] ARM: S3C2440: move mach-s3c2440/* into mach-s3c24xx/
> [PATCH 11/12] ARM: S3C2443: move mach-s3c2443/* into mach-s3c24xx/
could we move this forward please? :-)

As indicated by Olof's mail for tegra, we are near the 3.4 merge window and as 
is known everything must be in linux-next beforehand.

In my opinion it should also be possible to postpone the plat-s3c24xx cleanup 
for now and just bring this set on the road to reach 3.4.

Heiko
