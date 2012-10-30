From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 09:36:29 +0100
Subject: [PATCH 3/4] arm: mvebu: add Ethernet controllers using mvneta
 driver for Armada 370/XP
In-Reply-To: <CABMQnVKswTJr9Nd4Etx4Htv0Ckn+pDNqGO8MoPBH-x8y6CwZyA@mail.gmail.com>
References: <1351245804-31478-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351245804-31478-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CABMQnVKswTJr9Nd4Etx4Htv0Ckn+pDNqGO8MoPBH-x8y6CwZyA@mail.gmail.com>
Message-ID: <20121030093629.398ce706@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Oct 2012 13:19:15 +0900, Nobuhiro Iwamatsu wrote:

> > diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> > index 16cc82c..d484492 100644
> > --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> > +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> > @@ -68,6 +68,20 @@
> >                         compatible = "marvell,armada-addr-decoding-controller";
> >                         reg = <0xd0020000 0x258>;
> >                 };
> > +
> > +                ethernet at d0070000 {
> > +                               compatible = "marvell,armada-370-neta";
> > +                               reg = <0xd0070000 0x2500>;
> > +                               interrupts = <8>;
> > +                               status = "disabled";
> > +                };
> > +
> > +                ethernet at d0074000 {
> > +                               compatible = "marvell,armada-370-neta";
> > +                               reg = <0xd0074000 0x2500>;
> > +                               interrupts = <10>;
> > +                               status = "disabled";
> > +                };
> 
> Could you fit an indent?

Right, thanks, will fix.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
