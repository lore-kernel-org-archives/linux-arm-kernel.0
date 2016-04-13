From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 15:29:07 -0700
Subject: [GIT PULL 3/4] Rockchip dts32 updates for v4.7 - part1
In-Reply-To: <3837294.STogGfLSTd@diego>
References: <2557248.QNyQ7BnmgO@diego>
 <3837294.STogGfLSTd@diego>
Message-ID: <20160413222907.GJ19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 11:22:54AM +0200, Heiko St?bner wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.7-rockchip-dts32-1
> 
> for you to fetch changes up to fbf15046f12d6c8d5821c0dc5bf3ffc55a132243:
> 
>   ARM: dts: rockchip: move rk3036 memory definition to board files (2016-04-06 16:30:33 -0700)
> 
> ----------------------------------------------------------------
> A lot display-controller nodes for DSI and the Analogix DP on rk3288
> as well as general display+hdmi support on rk3036. With the Analogix
> DP support, Veyron Chromeboks can now finally use their internal
> display.
> 
> Other than this big improvement we have thermal support on the rk3228,
> a long time missing binding document for the General Register Files
> block, better operating points for Veyron devices and a bunch of fixes
> with parts stemming from warnings that new dtc version can generate.

Merged, thanks.


-Olof
