From: robh@kernel.org (Rob Herring)
Date: Tue, 15 Nov 2016 18:13:40 -0600
Subject: [RFC PATCH] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161114094411.30199-1-narmstrong@baylibre.com>
References: <20161114094411.30199-1-narmstrong@baylibre.com>
Message-ID: <20161116001340.wkqyh5wnygsnb5rk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 10:44:11AM +0100, Neil Armstrong wrote:
> Following the Amlogic Linux kernel, it seem the only differences
> between the GXL and GXM SoCs are the CPU Clusters.
> 
> Simply add a meson-gxm dtsi and reproduce the P23x to Q20x boards
> dts files since the S905D and S912 SoCs shares the same pinout
> and the P23x and Q20x boards are identical.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   2 +
>  .../arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts |  76 +++++++++
>  .../arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts |  57 +++++++
>  .../boot/dts/amlogic/meson-gxm-s912-q20x.dtsi      | 188 +++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         | 114 +++++++++++++
>  6 files changed, 443 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q20x.dtsi
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi

Acked-by: Rob Herring <robh@kernel.org>
