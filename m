From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 09:52:37 -0600
Subject: [PATCH v2 1/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
In-Reply-To: <20181114131627.17766-2-narmstrong@baylibre.com>
References: <20181114131627.17766-1-narmstrong@baylibre.com>
 <20181114131627.17766-2-narmstrong@baylibre.com>
Message-ID: <20181117155237.GA17417@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Nov 2018 14:16:25 +0100, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/soc/amlogic/clk-measure.txt          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
