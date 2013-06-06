From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 18:12:17 +0200
Subject: [PATCH V2] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <0a1201ce6268$d5a51610$80ef4230$%kim@samsung.com>
References: <0a1201ce6268$d5a51610$80ef4230$%kim@samsung.com>
Message-ID: <201306061812.18138.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013, Kukjin Kim wrote:
> As we discussed in mailing list, non-DT for EXYNOS SoCs will not be
> supported from v3.11. This patch removes regarding files for non-DT
> including board files and defconfig.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> 
> It's time to remove non-DT stuff for EXYNOS SoCs.
> If no objection on this, this will be sent to arm-soc in a couple of days.

Please do. I think there are no excuses left this time ;-)

However, I wonder if more code in arch/arm/plat-samsung can be made to
depend on the presence of ATAGS. I suspect there a lot of files that
we no longer need to build for an Exynos kernel now.

	Arnd
