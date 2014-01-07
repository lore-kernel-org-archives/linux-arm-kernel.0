From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 21:25:55 +0800
Subject: [PATCH] ARM: dts: vf610: use the interrupt macros
In-Reply-To: <e1421f5854394a4797628684293397da@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1387952367-6321-1-git-send-email-b32955@freescale.com>
 <20140106060429.GC27227@S2101-09.ap.freescale.net>
 <20140107075217.GA27279@shlinux2.ap.freescale.net>
 <e1421f5854394a4797628684293397da@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <20140107132553.GJ12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 09:39:09AM +0000, Jingchang Lu wrote:
> > > > @@ -90,7 +91,7 @@
> > > >  			uart0: serial at 40027000 {
> > > >  				compatible = "fsl,vf610-lpuart";
> > > >  				reg = <0x40027000 0x1000>;
> > > > -				interrupts = <0 61 0x00>;
> > >
> > > Why is it so special having a 0x00 IRQ trigger type?  Or is it just a
> > > typo?  While we are at it, we should probably fix it if it's a typo.
> > hi Jingchang:
> >   i think it is a typo.
> > 
> > do you any idea about it?
>   Yes, it is a typo I made, please help fix it here.

Okay.  I just fixed it up and applied the patch.

Shawn
