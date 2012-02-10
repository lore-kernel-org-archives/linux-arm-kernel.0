From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 17:35:15 +0900
Subject: [PATCH 8/9] ARM: EXYNOS: temporary add map definitions for uart
In-Reply-To: <CAH9JG2VU-rLQ=fQT5Jx5kPcHSLOiEcTVdFaQjsWnxA=Yr6i0Gg@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-9-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2VU-rLQ=fQT5Jx5kPcHSLOiEcTVdFaQjsWnxA=Yr6i0Gg@mail.gmail.com>
Message-ID: <00fb01cce7ce$e9674440$bc35ccc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---

[...]

> > +#ifdef CONFIG_ARCH_EXYNOS4
> > +#define S3C_PA_UART			EXYNOS4_PA_UART
> > +#endif
> > +
> > +#ifdef CONFIG_ARCH_EXYNOS5
> > +#define S3C_PA_UART			EXYNOS5_PA_UART
> > +#endif
> If it selects the both ARCH_EXYNOS4 and ARCH_EXYNOS5, how to handle
> this one? I think it's time to clean up these macro magic.

They will be updated for selection of EXYNOS4 and EXYNOS5 together in next
version.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
