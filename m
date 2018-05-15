From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:52:28 -0700
Subject: [GIT PULL 3/4] Rockchip dts64 updates for 4.18 round 1
In-Reply-To: <20114925.REm1YfjZS7@phil>
References: <2000491.bLgWuj0xar@phil>
 <20114925.REm1YfjZS7@phil>
Message-ID: <20180515205228.s5tfj5v5zngg2x64@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 12:39:26PM +0200, Heiko Stuebner wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-dts64-1
> 
> for you to fetch changes up to 17bd0737948aa841b76278a601217b914aa5f18e:
> 
>   arm64: dts: rockchip: enable hdmi on rk3399-puma-haikou (2018-05-03 14:38:20 +0200)
> 
> ----------------------------------------------------------------
> All iommus got their clocks added and rk3399 got support for its
> usb3-phy otg-port and better ajustment for the cpll child clocks.
> On the board side, all rk3399 got their typec phys enabled - which
> is needed for better usb support, the sapphire board got some more
> properties moved to the excavator baseboard where they really belong,
> kevin got a fix to use a real devicetree compatible and puma-haikou
> got its hdmi port enabled.

Merged, thanks!


-Olof
