From: sr@denx.de (Stefan Roese)
Date: Mon, 18 Jun 2012 11:08:50 +0200
Subject: [PATCH] ARM: SPEAr600: Fix timer interrupt definition in
 spear600.dtsi
In-Reply-To: <201206060845.09562.sr@denx.de>
References: <1336725661-29271-1-git-send-email-sr@denx.de>
 <201206060845.09562.sr@denx.de>
Message-ID: <201206181108.51023.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 June 2012 08:45:09 Stefan Roese wrote:
> On Friday 11 May 2012 10:41:01 Stefan Roese wrote:
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Cc: Viresh Kumar <viresh.kumar@st.com>
> > ---
> > 
> >  arch/arm/boot/dts/spear600.dtsi |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/spear600.dtsi
> > b/arch/arm/boot/dts/spear600.dtsi index 089f0a4..a3c36e4 100644
> > --- a/arch/arm/boot/dts/spear600.dtsi
> > +++ b/arch/arm/boot/dts/spear600.dtsi
> > @@ -181,6 +181,7 @@
> > 
> >  			timer at f0000000 {
> >  				compatible = "st,spear-timer";
> >  				reg = <0xf0000000 0x400>;
> > +				interrupt-parent = <&vic0>;
> >  				interrupts = <16>;
> >  			};
> >  		};
> 
> Ping.

Ping again (this is a real show-stopper for SPEAr600 in v3.5!).

Thanks,
Stefan
