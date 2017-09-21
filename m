From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 18:09:14 -0500
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: add DT binding
 for meson GPIO interrupt controller
In-Reply-To: <20170918134610.17743-3-jbrunet@baylibre.com>
References: <20170918134610.17743-1-jbrunet@baylibre.com>
 <20170918134610.17743-3-jbrunet@baylibre.com>
Message-ID: <20170921230914.sngqq6ls6fqqavwo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 03:46:09PM +0200, Jerome Brunet wrote:
> This commit adds the device tree bindings description for Amlogic's GPIO
> interrupt controller available on the meson8b, gxbb and gxl SoC families
> 
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../amlogic,meson-gpio-intc.txt                    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt

Acked-by: Rob Herring <robh@kernel.org>
