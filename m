From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 10:11:02 -0700
Subject: [PATCH] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <2f3001ce3515$9a9ae1b0$cfd0a510$%kim@samsung.com>
References: <2f3001ce3515$9a9ae1b0$cfd0a510$%kim@samsung.com>
Message-ID: <20130411171102.GA31066@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 08:30:14PM +0900, Kukjin Kim wrote:
> 
> As we discussed in mailing list, non-DT for EXYNOS SoCs will not be
> supported from v3.10. This patch removes regarding files for non-DT
> including board files.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/configs/exynos4_defconfig         |   68 --

I think you can just delete this and move the contents over to exynos_defconfig
instead.

The original argument for keeping exynos4_defconfig was to provide a defconfig
for non-DT platforms on exynos4. That's gone now, and you can just roll them
into exynos_defconfig instead.



-Olof
