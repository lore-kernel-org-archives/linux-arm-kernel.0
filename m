From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 18 Apr 2016 14:34:17 -0400
Subject: [PATCH 3/3] arm: dts: phy3250: enable ssp0
In-Reply-To: <57144AB1.6040304@mleia.com>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
 <1460636437-21764-4-git-send-email-slemieux.tyco@gmail.com>
 <57144AB1.6040304@mleia.com>
Message-ID: <1461004457.27294.0.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-18 at 05:47 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 14.04.2016 15:20, slemieux.tyco at gmail.com wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> 
> even a short commit message is highly appreciated, e.g. "this is a preparatory
> change prior to disabling SSPx controllers by default in the shared LPC32xx
> DTSI file".
> 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> >  arch/arm/boot/dts/phy3250.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
> > index a00d7ce..26e070f 100644
> > --- a/arch/arm/boot/dts/phy3250.dts
> > +++ b/arch/arm/boot/dts/phy3250.dts
> > @@ -146,6 +146,7 @@
> >  				#size-cells = <0>;
> >  				num-cs = <1>;
> >  				cs-gpios = <&gpio 3 5 0>;
> > +				status = "okay";
> >  
> >  				eeprom: at25 at 0 {
> >  					pl022,interface = <0>;
> > 
> 
> Could you please swap 2/3 and 3/3 ?
> 
OK, will submit v2 tomorrow.

> This may save some time to git-bisect users, if there are any :)
> 
> --
> With best wishes,
> Vladimir
