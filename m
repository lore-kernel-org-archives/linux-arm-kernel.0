From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 15:21:23 +0800
Subject: mxs: enable phy-clock in the driver?
In-Reply-To: <20234.37290.114047.36369@ipc1.ka-ro>
References: <20120108144558.GB2544@pengutronix.de>
 <20120109013404.GD1835@S2101-09.ap.freescale.net>
 <20234.35823.411762.856482@ipc1.ka-ro>
 <20120109065845.GL1835@S2101-09.ap.freescale.net>
 <20234.37290.114047.36369@ipc1.ka-ro>
Message-ID: <20120109072121.GN1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 08:05:14AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > On Mon, Jan 09, 2012 at 07:40:47AM +0100, Lothar Wa?mann wrote:
> > > The TX28 derives its PHY clock from the ENET_CLK pin of the
> > > processor. Thus the CLK_ENET_TIME should be enabled by the driver as
> > > mentioned in <20120108033238.GA19721@S2101-09.ap.freescale.net>
> > > 
> > Can you give a web link for that message?
> > 
> It's your own email from "Sun, 8 Jan 2012 11:32:40 +0800" with the
> subject "Re: MX28 fec clock frequency":
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/079556.html
> 
Ah, yes.  But what I said there is the CLK_ENET_TIME should be enabled
by PTP support, not the need of clocking external phy required by
particular board design.

-- 
Regards,
Shawn
