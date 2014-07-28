From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Jul 2014 13:59:41 +0200
Subject: [GIT PULL 1/2] ARM: dts: support for Rockchip RK3288
In-Reply-To: <5365614.PZrHpVmkns@wuerfel>
References: <2320363.GkHcuEZQtr@diego> <10597631.GFKQk34LQm@diego>
 <5365614.PZrHpVmkns@wuerfel>
Message-ID: <1467661.LyyKQKsLpv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 28. Juli 2014, 13:55:38 schrieb Arnd Bergmann:
> On Monday 28 July 2014 13:48:45 Heiko St?bner wrote:
> > The following changes since commit 
1fe69496cf463b654d2d6e1a9a10fb8d99f10831:
> >   ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER (2014-07-13 12:17:11
> >   -0700)
> > 
> > are available in the git repository at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> >   tags/v3.17-rockchip-rk3288> 
> > for you to fetch changes up to b1db66b818a4cb1a654ae51a5ca32a09d1ccd825:
> >   ARM: dts: Build dtbs for Rockchip boards (2014-07-26 13:07:27 +0200)
> 
> Hi Heiko,
> 
> I don't seem to have 1fe69496cf463b654 ("ARM: rockchip: Select
> ARCH_HAS_RESET_CONTROLLER") in arm-soc. Any idea what is going
> on?
> 
> Did I miss another pull request, or did you rebased your patches
> on the wrong branch?

hmm, the cover-letter was meant to explain this :-)

aka both requests need

 git://git.linaro.org/people/mike.turquette/linux.git clk-rockchip

as dependency


Heiko
