From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Apr 2015 11:58:51 +0200
Subject: [PATCH v11]: clk: Add common clock support for Mediatek MT8135
 and MT8173
In-Reply-To: <CABuKBeJ256HBLP+3WB+acNbMonGknQJgWBnGjEx1VWecWc-Y5g@mail.gmail.com>
References: <1427825817-26773-1-git-send-email-s.hauer@pengutronix.de>
 <CABuKBeJ256HBLP+3WB+acNbMonGknQJgWBnGjEx1VWecWc-Y5g@mail.gmail.com>
Message-ID: <20150413095851.GN9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 01:47:58PM +0200, Matthias Brugger wrote:
> Hi Sascha,
> 
> 
> 2015-03-31 20:16 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> >
> > The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:
> >
> >   Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.pengutronix.de/git/imx/linux-2.6.git tags/v4.0-clk-mediatek-v11
> >
> > for you to fetch changes up to ae9129219143cfdefe8b3a463deb8c5cb8955525:
> >
> >   dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers (2015-03-31 20:08:46 +0200)
> >
> > ----------------------------------------------------------------
> > This patchset contains the initial common clock support for Mediatek SoCs.
> > Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
> > and clock gates.
> 
> I tried the patch set on my mt8135 eval board. I used the dts bindings
> from a former version of this set [1], but it does not boot the board
> (based on v4.0-rc7).
> Do you have any hint, what is happening, or are the bindings wrong?

I can give this a test tomorrow.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
