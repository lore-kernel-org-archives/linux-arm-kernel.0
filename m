From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Mar 2014 15:39:18 +0100
Subject: [PATCH v3 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <20140313212725.GF2696@katana>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140313212725.GF2696@katana>
Message-ID: <20140324143918.GJ5416@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:27:25PM +0100, Wolfram Sang wrote:
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> > index 4cc2f5f2ecad..c1fd510fd2c4 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -762,7 +762,7 @@
> >  		};
> >  
> >  		i2c0: i2c at 01c2ac00 {
> > -			compatible = "allwinner,sun4i-i2c";
> > +			compatible = "allwinner,sun4i-a10-i2c";
> 
> I still wonder why there is no "allwinner,sun4i-a20-i2c" entry first
> (even if there is no similar entry in the driver *yet*). 

Ahh, I didn't understand it like that in your previous mail. Yes, it
makes sense.

I'll update the patches and resend.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/76b58905/attachment.sig>
