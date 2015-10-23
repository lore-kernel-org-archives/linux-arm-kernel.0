From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:55:13 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <4745252.gLSrJNQ42D@wuerfel>
References: <20151023180711.GA11749@lukather> <4745252.gLSrJNQ42D@wuerfel>
Message-ID: <9946613.K7Ehp1DEiL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 22:41:04 Arnd Bergmann wrote:
> On Friday 23 October 2015 20:07:11 Maxime Ripard wrote:
> > Allwinner DT changes for 4.4, round 3
> > 
> > A bunch of new boards, but mostly enable the support for the Audio Codec
> > on the older SoCs (A10, A10s, A13, A20, R8) and enable it on various
> > boards.
> > 
> > 
> 
> Pulled into next/dt, thanks!

And dropped again:

In file included from /git/arm-soc/arch/arm/boot/dts/sun4i-a10-a1000.dts:46:0:
/git/arm-soc/arch/arm/boot/dts/sun4i-a10.dtsi:48:46: fatal error: dt-bindings/clock/sun4i-a10-pll2.h: No such file or directory

Please make sure branches you send actually work by themselves.

	Arnd
