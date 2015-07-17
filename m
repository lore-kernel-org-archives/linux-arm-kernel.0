From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:38:04 -0700
Subject: [GIT PULL 2/2] Rockchip dts changes for 4.3, part1
In-Reply-To: <43550625.L2USv7p8yj@diego>
References: <2820374.NgluYWXZkW@diego>
 <43550625.L2USv7p8yj@diego>
Message-ID: <20150717173804.GL21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 12:36:22AM +0200, Heiko St?bner wrote:
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-dts1
> 
> for you to fetch changes up to 4863dcd394019b542ac968870cba734d27e992e0:
> 
>   ARM: dts: rockchip: add rk3288 arm-pmu irq affinity (2015-07-16 22:22:47 +0200)
> 
> ----------------------------------------------------------------
> This adds the board for the Netxeon R89 used in different
> TV-boxes and the initial support for two Chromebooks from
> the veyron family.
> Additionally a non-critical fix for the watchdog irq
> on rk3288, addition of the gmac reset line, a ramp delay
> for the cpu regulator on the firefly board and cpu affinity
> for the arm-pmu spi irqs.

Thanks, merged.


-Olof
