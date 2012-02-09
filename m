From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 09 Feb 2012 09:44:51 +0900
Subject: [PATCH] ARM: EXYNOS: Configure ARM_NR_BANKS for EXYNOS SoC
In-Reply-To: <20120208084716.GG889@n2100.arm.linux.org.uk>
References: <003201cce600$81c8f100$855ad300$%kim@samsung.com>
 <20120208084716.GG889@n2100.arm.linux.org.uk>
Message-ID: <000001cce6c4$0e1fb800$2a5f2800$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> >
> >  config ARM_NR_BANKS
> >  	int
> > -	default 16 if ARCH_EP93XX
> > +	default 16 if ARCH_EP93XX || ARCH_EXYNOS4 || ARCH_EXYNOS5
>
> ARCH_EXYNOS ?
ARCH_EXYNOS5 may support the bigger memory than 4GB because it's running series.
Anyway ARCH_EXYNOS seems be better now. I will resend it soon.
Thank you..

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
