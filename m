From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 10 Jan 2018 19:58:25 +0000
Subject: [RFC PATCH] drivers: soc: xilinx: Add ZynqMP power domain driver
In-Reply-To: <CAOFm3uFGuhBzXRrnuaFbdmjXSfq8Gm+Of93e3ovzdTZN1YaF9g@mail.gmail.com>
References: <1515449572-5398-1-git-send-email-jollys@xilinx.com>
 <CAOFm3uFGuhBzXRrnuaFbdmjXSfq8Gm+Of93e3ovzdTZN1YaF9g@mail.gmail.com>
Message-ID: <DM2PR0201MB076714477CD660B8F32D3D56B8110@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Philippe for review,

> -----Original Message-----
> From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
> Sent: Tuesday, January 09, 2018 4:48 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>; Andy Gross
> <andy.gross@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> geert+renesas at glider.be; Bjorn Andersson <bjorn.andersson@linaro.org>; Sean
> Wang <sean.wang@mediatek.com>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Michal Simek <michal.simek@xilinx.com>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>; LKML <linux-kernel@vger.kernel.org>; Jolly Shah
> <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [RFC PATCH] drivers: soc: xilinx: Add ZynqMP power domain driver
> 
> Jolly,
> 
> On Mon, Jan 8, 2018 at 11:12 PM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> > The zynqmp-genpd driver communicates the usage requirements for
> > logical power domains / devices to the platform FW.
> > FW is responsible for choosing appropriate power states, taking Linux'
> > usage information into account.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/drivers/soc/xilinx/zynqmp/pm_domains.c
> > @@ -0,0 +1,343 @@
> > +/*
> > + * ZynqMP Generic PM domain support
> > + *
> > + *  Copyright (C) 2014-2017 Xilinx, Inc.
> > + *
> > + *  Davorin Mista <davorin.mista@aggios.com>
> > + *  Jolly Shah <jollys@xilinx.com>
> > + *  Rajan Vaja <rajanv@xilinx.com>
> > + *
> > + * SPDX-License-Identifier:     GPL-2.0+
> > + */
> 
> This tag should be on the fist line as this:
> 
> // SPDX-License-Identifier: GPL-2.0+
> 
> --
> Cordially
> Philippe Ombredanne

Will fix it in next version
