From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Thu, 5 Jun 2014 18:44:26 +0200
Subject: [PATCH 3/9] ARM: dts: berlin: add a required reset property in
 the chip controller node
In-Reply-To: <1401986347.4103.11.camel@paszta.hi.pengutronix.de>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-4-git-send-email-antoine.tenart@free-electrons.com>
 <1401986347.4103.11.camel@paszta.hi.pengutronix.de>
Message-ID: <20140605164426.GA21960@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 06:39:07PM +0200, Philipp Zabel wrote:
> Am Donnerstag, den 05.06.2014, 17:48 +0200 schrieb Antoine T?nart:
> > The chip controller node now also describes the Marvell Berlin reset
> > controller. Add the required 'reset-cells' property.
> > 
> > Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/berlin2.dtsi   | 1 +
> >  arch/arm/boot/dts/berlin2cd.dtsi | 1 +
> >  arch/arm/boot/dts/berlin2q.dtsi  | 1 +
> >  3 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> > index 2477dac4d643..379ff1a38377 100644
> > --- a/arch/arm/boot/dts/berlin2.dtsi
> > +++ b/arch/arm/boot/dts/berlin2.dtsi
> > @@ -243,6 +243,7 @@
> >  		chip: chip-control at ea0000 {
> >  			compatible = "marvell,berlin2-chip-ctrl";
> >  			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> 
> Are the marvell,berlin2q-chip-ctrl bindings already documented? This
> should also be added to the documentation.

It is, I'll add information about its reset function.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
