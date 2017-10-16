From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 Oct 2017 11:34:57 +0200
Subject: [PATCH 0/2] Introduce new DT files for Meson-AXG SoC
In-Reply-To: <20171013231313.22850-1-dlan@gentoo.org>
References: <20171013231313.22850-1-dlan@gentoo.org>
Message-ID: <90f8d36a-c045-7851-19ce-ce2cfcc619d6@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2017 01:13, Yixun Lan wrote:
> This attempt will try to add new DT files to support Meson-AXG SoC.
> Due to the AXG series has new memory layout, we decide to start a new
> DT structure without sharing with previous meson-gx.dtsi
> 
> 1) in the first patch, we try to document the new Meson-AXG bindings
> 2) in the second patch, we try to bring up a minimal serial console,
> so it's capable of running a minimal system (in ramdisk).
> 
> 
> Yixun Lan (2):
>   dt-bindings: arm: amlogic: Add Meson AXG binding
>   arm64: dts: meson-axg: add initial A113D SoC DT support
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts    |  22 +++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 204 ++++++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
