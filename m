From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Mar 2015 11:54:03 +0800
Subject: [PATCH 2/2] ARM: dts: hummingboard: Setup pwm lines
In-Reply-To: <1425379336.3146.38.camel@pengutronix.de>
References: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
 <1425379336.3146.38.camel@pengutronix.de>
Message-ID: <20150330035402.GM28410@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:42:16AM +0100, Philipp Zabel wrote:
> > +&pwm3 {
> > +	status = "disabled";
> > +};
> > +
> > +&pwm4 {
> > +	status = "disabled";
> > +};
> 
> I wanted to point out these two are superfluous since pwm3/4 are
> disabled in the dtsi by default, but I just learned they aren't.
> 
> Should we add status = "disabled" to unusable (because not externally
> connected) PWMs, and if so, shouldn't that be done in the dtsi already?

Thanks Philipp for your patch "ARM: dts: imx6qdl: disable PWMs by
default".  Therefore I dropped pwm3/4 and applied the patch.

Shawn
