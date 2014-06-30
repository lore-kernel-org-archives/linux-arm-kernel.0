From: a.heider@gmail.com (Andre Heider)
Date: Mon, 30 Jun 2014 21:40:47 +0200
Subject: [PATCH 12/13] ARM: dts: am33xx: add the PRUSSv2 device
In-Reply-To: <20140630093642.GV7262@leverpostej>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-13-git-send-email-a.heider@gmail.com>
 <20140630093642.GV7262@leverpostej>
Message-ID: <20140630194047.GC78749@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:36:42AM +0100, Mark Rutland wrote:
> On Sun, Jun 29, 2014 at 05:21:46PM +0100, Andre Heider wrote:
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -409,6 +409,15 @@
> >  			ti,hwmods = "rtc";
> >  		};
> >  
> > +		pruss: pruss at 4a300000 {
> > +			compatible = "ti,pruss-v2";
> > +			ti,hwmods = "pruss";
> > +			reg = <0x4a300000 0x080000>;
> > +			interrupts = <20 21 22 23 24 25 26 27>;
> 
> Could this please have entries individually bracketed?

I'll sync that to with what we end up with on path 7.

Thanks,
Andre
