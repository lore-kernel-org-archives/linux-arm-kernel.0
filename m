From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 18 Mar 2016 10:08:51 +0800
Subject: [PATCH 00/10] ARM: dts: rockchip: enable edp functionality
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <56EB6333.3040104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 03/18/2016 09:39 AM, Heiko Stuebner wrote:
> This is the companion series to Yakir's rework of the analogix-dp
> driver used both by Exynos and Rockchip.
>
> These patches have been sitting in my tree for some time, and already
> got tested (and thus refined) by a number of people.
>
> So I'll post them now, to get applied after the driver-side gets
> accepted hopefully soonish.
Thanks very much about this cool work ;)

- Yakir
>
> Caesar Wang (1):
>    ARM: dts: rockchip: add rk3288-veyron-jaq backlight and panel
>      overrides
>
> Heiko Stuebner (9):
>    ARM: dts: rockchip: add rk3288 edp-phy node
>    ARM: dts: rockchip: add rk3288 displayport controller node
>    ARM: dts: rockchip: move edp-hpd pin definition into common location
>    ARM: dts: rockchip: add startup delay to rk3288-veyron
>      panel-regulators
>    ARM: dts: rockchip: add core rk3288-veyron backlight and panel nodes
>    ARM: dts: rockchip: add rk3288-veyron-minnie backlight and panel
>      settings
>    ARM: dts: rockchip: override edp hpd handling on veyron-pinky and
>      speedy
>    ARM: dts: rockchip: simple panel and backlight supplies on veyron
>      boards
>    ARM: dts: rockchip: enable the eDP on rk3288 veyron devices
>
>   arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 100 ++++++++++++++++++++++++
>   arch/arm/boot/dts/rk3288-veyron-jaq.dts         |  49 ++++++++++--
>   arch/arm/boot/dts/rk3288-veyron-jerry.dts       |   9 +++
>   arch/arm/boot/dts/rk3288-veyron-minnie.dts      |  44 +++++++++++
>   arch/arm/boot/dts/rk3288-veyron-pinky.dts       |   7 ++
>   arch/arm/boot/dts/rk3288-veyron-speedy.dts      |  16 ++++
>   arch/arm/boot/dts/rk3288.dtsi                   |  59 ++++++++++++++
>   7 files changed, 278 insertions(+), 6 deletions(-)
>
