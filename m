From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Sep 2016 09:36:21 +0800
Subject: [PATCH v5 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5DkMaRFwzH7HY872pLUdDrZfMq0xqLG+Xv88ut3Jd5Saw@mail.gmail.com>
References: <1468235521-3163-1-git-send-email-p.zabel@pengutronix.de>
 <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
 <5787C558.5060904@gmail.com> <2499789.N9zTF3cNAV@diplodocus>
 <CAOMZO5CPM9YfVqfpuyLmhGn9jC7p73Ocnc7LxE9=xA9ouawNQQ@mail.gmail.com>
 <CACrMeVA8CdL-Fqa4NwmBUPvzBXsi=o8bpB_tY2-Z0-xCoMX3xA@mail.gmail.com>
 <CAOMZO5DkMaRFwzH7HY872pLUdDrZfMq0xqLG+Xv88ut3Jd5Saw@mail.gmail.com>
Message-ID: <20160916013621.GB7398@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 12:15:40PM -0300, Fabio Estevam wrote:
> Hi Akshay and Charles,
> 
> On Mon, Sep 12, 2016 at 12:09 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> 
> > Hi Fabio, Shawn,
> >
> > Advantech tested the v5 patch series on imx6q-b450v3 board (with 4.7
> > kernel) and confirmed the patch fixes the lvds blank display issue
> > being seen on some imx6q-b450v3 boards.
> >
> > Details below:
> > With the patch applied:
> > Board # 1: 100 times power on/off, no LVDS display failure
> > Board # 2: 100 times power on/off, no LVDS display failure
> >
> > Without the patch:
> > Board # 1: LVDS display failure (blank display output) at 4th time power on/off.
> > Board # 2: LVDS display failure (blank display output) at 3rd time power on/off.
> >
> > Tested-by: Charles Kang <Charles.Kang@advantech.com.tw>
> 
> Thanks for testing it.
> 
> > Since the patch has been reviewed and confirmed to fix display
> > failures on 2 different boards (imx6q-evi and imx6q-b450v3), can it be
> > applied?
> 
> Yes, I think this series is in a good shape now.
> 
> Shawn,
> 
> Are you happy with it?

Acked-by: Shawn Guo <shawnguo@kernel.org>

Please send it to clk maintainers for applying.

Shawn
