From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 13:24:13 -0500
Subject: [PATCH v4 2/2] ARM: dts: rockchip: add rk3288-based Tinker board S
In-Reply-To: <20180923113807.11558-3-heiko@sntech.de>
References: <20180923113807.11558-1-heiko@sntech.de>
 <20180923113807.11558-3-heiko@sntech.de>
Message-ID: <20180927182413.GA1990@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Sep 2018 13:38:07 +0200, Heiko Stuebner wrote:
> From: David Summers <beagleboard@davidjohnsummers.uk>
> 
> Add the actual dts for the tinker board S, which brings its own emmc
> device, not therefore not requiring an sd-card to boot.
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/arm/rockchip.txt      |  4 +++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/rk3288-tinker-s.dts         | 26 +++++++++++++++++++
>  3 files changed, 31 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
