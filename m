From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:26:35 +0900
Subject: [PATCH 3/4] arm/dts: exynos4: Add DTS file for ODROID-X
In-Reply-To: <CAJuYYwTp00RohqKkF6+4yxq3bqW1O6NWkab29PuyEUPYTjeqgw@mail.gmail.com>
References: <1344366725-19153-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <CAJuYYwTp00RohqKkF6+4yxq3bqW1O6NWkab29PuyEUPYTjeqgw@mail.gmail.com>
Message-ID: <09a201cd96be$35d24de0$a176e9a0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> On 8 August 2012 00:42, Dongjin Kim <tobetter@gmail.com> wrote:
> > This patch create a DTS file for ODROID-X, it desribes PMIC max77686 and
> LED
> > gpios base.
> >
> > Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>
> > ---
> >  arch/arm/boot/dts/exynos4412-odroidx.dts |  148
> ++++++++++++++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/exynos4412-odroidx.dts
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts
> b/arch/arm/boot/dts/exynos4412-odroidx.dts
> > new file mode 100644
> > index 0000000..b0a892b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> > @@ -0,0 +1,148 @@
> > +/*
> > + * Samsung's Exynos4210 based Origen board device tree source
> > + *
> > + * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> > + *             http://www.samsung.com
> > + * Copyright (c) 2010-2011 Linaro Ltd.
> > + *             www.linaro.org
> > + *
> > + * Device tree source file for Insignal's Origen board which is based
> on
> > + * Samsung's Exynos4210 SoC.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +/dts-v1/;
> > +/include/ "exynos4412.dtsi"
> > +/include/ "max77686.dtsi"
> > +
> > +/ {
> > +       model = "Hardkernel ODROID-X evaluation board based on
> Exynos4412";
> > +       compatible = "hardkernel,odroidx", "samsung,exynos4412";
> 
> The compatible value "samsung,exynos4412" can be added to the
> compatible list in mach-exynos4-dt.c file. Otherwise, this looks fine.
> 
Dongjin, any updates on this?

K-Gene <kgene@kernel.org>
