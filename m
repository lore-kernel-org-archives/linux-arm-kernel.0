From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 26 Oct 2015 03:26:31 -0700
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <20151025201308.GS10947@lukather>
References: <20151023180711.GA11749@lukather> <4745252.gLSrJNQ42D@wuerfel>
 <9946613.K7Ehp1DEiL@wuerfel> <20151025201308.GS10947@lukather>
Message-ID: <20151026102631.20687.88931@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2015-10-25 13:13:08)
> On Fri, Oct 23, 2015 at 10:55:13PM +0200, Arnd Bergmann wrote:
> > On Friday 23 October 2015 22:41:04 Arnd Bergmann wrote:
> > > On Friday 23 October 2015 20:07:11 Maxime Ripard wrote:
> > > > Allwinner DT changes for 4.4, round 3
> > > > 
> > > > A bunch of new boards, but mostly enable the support for the Audio Codec
> > > > on the older SoCs (A10, A10s, A13, A20, R8) and enable it on various
> > > > boards.
> > > > 
> > > > 
> > > 
> > > Pulled into next/dt, thanks!
> > 
> > And dropped again:
> > 
> > In file included from /git/arm-soc/arch/arm/boot/dts/sun4i-a10-a1000.dts:46:0:
> > /git/arm-soc/arch/arm/boot/dts/sun4i-a10.dtsi:48:46: fatal error: dt-bindings/clock/sun4i-a10-pll2.h: No such file or directory
> > 
> > Please make sure branches you send actually work by themselves.
> 
> Damn, you're right... Sorry about that...
> 
> You need to pull the tag sunxi-clk-for-4.4 that has been merged in the
> clk tree in 38ce30e29dc.
> 
> Mike, Stephen, will that tag be stable?

Yes.

Regards,
Mike

> 
> Arnd, do you want me to merge it in my DT branch, or do you want to
> merge it yourself?
> 
> Thanks, and sorry again,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
