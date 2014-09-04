From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Sep 2014 22:00:12 +0200
Subject: [GIT PULL] first bunch of dts changes for 3.18
In-Reply-To: <1937322.lt3suVLyIs@diego>
References: <1937322.lt3suVLyIs@diego>
Message-ID: <201409042200.12768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014, Heiko St?bner wrote:
> here is a first bunch of dts changes for 3.18. A lot of material for
> the rk3288 and some other smaller adaptions for changes happening
> in other trees (dw_mmc conversion, accepted saradc driver in the iio tree).
> 
> So please pull
> 
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-dts1
> 
> for you to fetch changes up to f23a6179d45e9d144bf2eb2bd82b2f1270f85fcf:
> 
>   ARM: dts: rockchip: add saradc nodes (2014-08-27 23:43:01 +0200)
> 
> ----------------------------------------------------------------
> First hunk of Rockchip dts changes for 3.18
> - dw_mmc conversion from Jaehoon Chung
> - mmc support for rk3288
> - pwm + backlight for rk3288
> - rtc for Radxa Rock
> - saradc base nodes

Pulled into next/dt, thanks!

	Arnd
