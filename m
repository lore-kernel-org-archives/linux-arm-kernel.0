From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 17 Sep 2015 09:04:16 +0800
Subject: [PATCH] ARM: dts: vfxxx: Add iio_hwmon node for ADC temperature
 channel
In-Reply-To: <20150907084911.GA6877@Sanchayan-Arch.toradex.int>
References: <b639ca620369d196491a4af8739b87d580e71bf6.1438876380.git.maitysanchayan@gmail.com>
 <20150906043232.GD30746@tiger>
 <20150907084911.GA6877@Sanchayan-Arch.toradex.int>
Message-ID: <20150917010416.GH30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:19:11PM +0530, maitysanchayan at gmail.com wrote:
> Hi Shawn,
> 
> On 15-09-06 12:32:32, Shawn Guo wrote:
> > On Thu, Aug 06, 2015 at 09:28:22PM +0530, Sanchayan Maity wrote:
> > > Add iio_hwmon node to expose the temperature channel on Vybrid
> > > as hardware monitor device using the iio_hwmon driver.
> > > 
> > > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > > index 39173bb..0993d66 100644
> > > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > > @@ -597,5 +597,10 @@
> > >  				status = "disabled";
> > >  			};
> > >  		};
> > > +
> > > +		iio_hwmon {
> > 
> > Hyphen rather than underscore should be used in node name.
> 
> As per iio-bindings.txt I did this. It is the same in imx23.dtsi and imx28.dtsi.
> 
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/iio-bindings.txt#L85
> http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx23.dtsi#L570
> http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx28.dtsi#L1246

Oh, sorry, all these should be caught earlier.

> 
> So should this be changed?

Yeah, that would be nice, if the change doesn't break anything.

Shawn
