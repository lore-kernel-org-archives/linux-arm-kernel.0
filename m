From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 06 Jul 2018 16:46:40 +0200
Subject: [PATCH 0/2] Add support for S805X based P241 Reference Design
 board
In-Reply-To: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1530888400.3023.10.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-05 at 11:50 +0200, Neil Armstrong wrote:
> Neil Armstrong (2):
>   dt-bindings: amlogic: Add support for GXL S805X and the P241 board
>   ARM64: dts: add S805X based P241 board
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      | 218 +++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts

Looks good to me

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
