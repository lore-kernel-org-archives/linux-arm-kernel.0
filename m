From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 18:47:34 -0500
Subject: [PATCH 2/2] ARM64: dts: meson-gxm: Add support for Khadas VIM2
In-Reply-To: <1505832820-3517-3-git-send-email-narmstrong@baylibre.com>
References: <1505832820-3517-1-git-send-email-narmstrong@baylibre.com>
 <1505832820-3517-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170921234734.nbjvpz2vukywyrci@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 04:53:40PM +0200, Neil Armstrong wrote:
> The Khadas VIM2 is a Single Board Computer, respin of the origin
> Khadas VIM board, using an Amlogic S912 SoC and more server oriented.
> 
> It provides the same external connectors and header pinout, plus a SPI
> NOR Flash, a reprogrammable STM8S003 MCU, FPC Connector, Cooling FAN header
> and Pogo Pads Arrays.
> 
> Cc: Gouwa <gouwa@szwesion.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 401 +++++++++++++++++++++
>  3 files changed, 403 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts

Acked-by: Rob Herring <robh@kernel.org>
