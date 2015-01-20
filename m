From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Tue, 20 Jan 2015 08:44:09 +0000
Subject: [PATCH net-next 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb board
 enet phy address
In-Reply-To: <20150120083156.GY2766@dragon>
References: <1421660282-29494-1-git-send-email-b38611@freescale.com>
 <20150120083156.GY2766@dragon>
Message-ID: <BLUPR03MB3732D6601E8D5F5CD12D348F54B0@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org> Sent: Tuesday, January 20, 2015 4:32 PM
> To: Duan Fugang-B38611
> Cc: davem at davemloft.net; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; s.hauer at pengutronix.de; stefan at agner.ch
> Subject: Re: [PATCH net-next 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb
> board enet phy address
> 
> On Mon, Jan 19, 2015 at 05:38:02PM +0800, Fugang Duan wrote:
> > The commit (3d125f9c91c5) cause i.MX6SX sdb enet cannot work. The
> > cause is the commit add mdio node with un-correct phy address.
> >
> > The patch just correct i.MX6sx sdb board enet phy address.
> >
> > Signed-off-by: Fugang Duan <B38611@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6sx-sdb.dts |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts
> > b/arch/arm/boot/dts/imx6sx-sdb.dts
> > index 8c1febd..9db123f 100644
> > --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> > @@ -167,11 +167,11 @@
> >  		#size-cells = <0>;
> >
> >  		ethphy1: ethernet-phy at 0 {
> 
> The unit-address should match 'reg' property, so it needs an update too.
> 
> Shawn

Yes, you are right.
I update it and send the next version.

Thanks,
Andy
