From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 13 Apr 2013 16:04:46 +0200
Subject: [PATCHv2 04/10] arm: kirkwood: add SoC-level Device Tree data
 for PCIe interfaces
In-Reply-To: <20130413103057.GG2824@lunn.ch>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130413103057.GG2824@lunn.ch>
Message-ID: <20130413160446.4fa00358@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sat, 13 Apr 2013 12:30:57 +0200, Andrew Lunn wrote:
> > diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi
> > b/arch/arm/boot/dts/kirkwood-6281.dtsi index d6c9d65..5137668 100644
> > --- a/arch/arm/boot/dts/kirkwood-6281.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
> > @@ -40,5 +40,36 @@
> >  				marvell,function = "sdio";
> >  			};
> >  		};
> > +
> > +		pcie-controller {
> 
> Hi Thomas
> 
> Convention seems to be to use _ not - in these names.

As we discussed on IRC, there are quite a number of .dts/.dtsi files
that use '-' in DT node names. Also, the PCIe DT patches for Armada
370/XP have already been merged by Jason with this exact node name. I'm
fine changing it specifically for Kirkwood, but that would make it
inconsistent with what we have for Armada 370/XP.

Jason, what do you think?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
