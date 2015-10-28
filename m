From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 10:06:57 +0300
Subject: [PATCH v2 1/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <56302F1F.5090206@samsung.com>
References: <cover.1445935215.git.p.fedin@samsung.com>
 <91ae80f172192fa4dbc8bf8ee5a9068661592de6.1445935215.git.p.fedin@samsung.com>
 <56302F1F.5090206@samsung.com>
Message-ID: <009001d1114f$3c7a1f60$b56e5e20$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +		sromc: sromc at 12250000 {
> > +			compatible = "samsung,exynos-srom";
> > +			reg = <0x12250000 0x10>;
> 
> Isn't 0x10 too small (SROM_BC3 won't be mapped)?

 Muhaha, indeed, thanks for noticing this.
 By the way, i've just checked exynos4.dtsi and exynos5.dtsi, they specify the same size. Did reviewers overlook this small thing?
Shouldn't it be fixed then?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
