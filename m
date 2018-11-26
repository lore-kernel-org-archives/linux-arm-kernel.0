From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 10:05:59 -0600
Subject: [PATCH v3 1/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
In-Reply-To: <20181118135310.31458-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
 <20181118135310.31458-1-narmstrong@baylibre.com>
Message-ID: <20181126160559.GA8094@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 02:53:10PM +0100, Neil Armstrong wrote:
> The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Rob,
> 
> I didn't take your v2 Reviewed-by since I changed the compatible list,
> tell me if i can still keep the tag.

Reviewed-by: Rob Herring <robh@kernel.org>

>  
> Thanks,
> Neil
> 
>  .../bindings/soc/amlogic/clk-measure.txt       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
