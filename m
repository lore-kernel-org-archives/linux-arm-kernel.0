From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 03 Dec 2014 01:08:28 +0100
Subject: [PATCH] cpuidle: add MAINTAINERS entry for ARM Exynos cpuidle
 driver
In-Reply-To: <1616359.KRpRrFqxfV@amdc1032>
References: <1616359.KRpRrFqxfV@amdc1032>
Message-ID: <1466322.AKaPtIKjPo@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 02, 2014 04:41:35 PM Bartlomiej Zolnierkiewicz wrote:
> Since there has been quite a lot of development going on for
> ARM Exynos cpuidle driver recently I would like to add separate
> MAINTAINERS entry for it and add myself as the primary maintainer.
> 
> The merging process would remain (almost) unchanged with patches
> going (with my Ack) through Daniel's or Kukjin's tree.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Daniel, do you want me to apply this, or are you going to do that?

> ---
>  MAINTAINERS |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: b/MAINTAINERS
> ===================================================================
> --- a/MAINTAINERS	2014-11-27 18:02:51.988225868 +0100
> +++ b/MAINTAINERS	2014-12-02 15:56:52.792997513 +0100
> @@ -2701,6 +2701,16 @@ T:	git git://git.kernel.org/pub/scm/linu
>  S:	Maintained
>  F:	drivers/cpuidle/cpuidle-big_little.c
>  
> +CPUIDLE DRIVER - ARM EXYNOS
> +M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> +M:	Daniel Lezcano <daniel.lezcano@linaro.org>
> +M:	Kukjin Kim <kgene@kernel.org>
> +L:	linux-pm at vger.kernel.org
> +L:	linux-samsung-soc at vger.kernel.org
> +S:	Supported
> +F:	drivers/cpuidle/cpuidle-exynos.c
> +F:	arch/arm/mach-exynos/pm.c
> +
>  CPUIDLE DRIVERS
>  M:	Rafael J. Wysocki <rjw@rjwysocki.net>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
