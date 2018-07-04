From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 04 Jul 2018 11:43:36 +0200
Subject: [PATCH 0/4] arm64: dts: rockchip: add RK3399-Gru-Bob and prepare
 for Scarlet
In-Reply-To: <20180614113039.29117-1-heiko@sntech.de>
References: <20180614113039.29117-1-heiko@sntech.de>
Message-ID: <6791706.GCJnhTN1Ea@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14. Juni 2018, 13:30:35 CEST schrieb Heiko Stuebner:
> So far the Gru series of ChromeOS devices has seen 3 public devices.
> Two clamshell devices with the already supported Kevin and Bob
> (aka Chromebook Flip C101PA), as well as one table-style device Scarlet.
> 
> So this series not only adds a devicetree file for Bob, but also prepares
> for Scarlets arrival, in that common properties of the clamshell-devices
> get moved into a rk3399-gru-chromebook.dtsi, similar to what we have on
> RK3288-Veyron, as Scarlet does some things a bit differently.
> 
> Scarlet itself needs a bit more time, as its display is connected via
> dual-dsi, where the patches are still pending.
> 
> 
> Heiko Stuebner (4):
>   arm64: dts: rockchip: move Chromebook-specific Gru-parts to a separate
>     file
>   arm64: dts: rockchip: add phandles to some nodes on rk3399-gru
>   arm64: dts: rockchip: move core edp from rk3399-kevin to shared
>     chromebook
>   arm64: dts: rockchip: add Google Bob

nobody complained for 3 weeks, so I've applied these 4 patches
for 4.19.
