From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 9 Jan 2018 17:30:15 +0800
Subject: [PATCH 3/7] ARM: dts: imx6ull: add additional pinfunc defines
 for i.MX 6ULL
In-Reply-To: <b183c2a38596cd3f3726777c79e027f9@agner.ch>
References: <20180102164223.15230-1-stefan@agner.ch>
 <20180102164223.15230-3-stefan@agner.ch>
 <20180105164930.qomk75eo7vzyglvn@rob-hp-laptop>
 <b183c2a38596cd3f3726777c79e027f9@agner.ch>
Message-ID: <20180109093015.GC26312@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 07, 2018 at 10:52:39AM +0100, Stefan Agner wrote:
> On 2018-01-05 17:49, Rob Herring wrote:
> > On Tue, Jan 02, 2018 at 05:42:19PM +0100, Stefan Agner wrote:
> >> From: Bai Ping <ping.bai@nxp.com>
> >>
> >> On i.MX 6ULL, the pin MUX and CTRL register of BOOT_MODEx and TAMPERx
> >> pins are available through IOMUXC_SNVS. Add additional pinfunc defines.
> >>
> >> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  arch/arm/boot/dts/imx6ull-pinfunc-snvs.h | 29 +++++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/imx6ull.dtsi           |  1 +
> >>  2 files changed, 30 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
> >>
> >> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
> >> new file mode 100644
> >> index 000000000000..da3f412e4269
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
> >> @@ -0,0 +1,29 @@
> >> +/*
> >> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > 
> > It's 2018 now.
> > 
> 
> I don't think you are supposed to chance copyright year unless you
> change it significantly.
> 
> At least that article suggests so:
> https://www.copyrightlaws.com/copyright-notice-year/
> 
> I took that patch from the downstream NXP kernel, so I guess 2016 was
> the year of first publication...
> 

Can you help add below copyright if you keep NXP sign-off as Author?
Then you don't need delete the old one.

Copyright 2017 NXP.

And SPDX mentioned by Rob.

Otherwise,
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> > 
> > Use SPDX. With that,
> 
> Agreed.
> 
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> --
> Stefan
