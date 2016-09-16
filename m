From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Sep 2016 10:33:05 -0500
Subject: [PATCH 1/2] dt-bindings: spi-meson: Add GXBB Compatible string
In-Reply-To: <1473321206-32284-2-git-send-email-narmstrong@baylibre.com>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <1473321206-32284-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160916153305.GB6795@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 09:53:25AM +0200, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
> index bb52a86..dc6d031 100644
> --- a/Documentation/devicetree/bindings/spi/spi-meson.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
> @@ -7,7 +7,7 @@ NOR memories, without DMA support and a 64-byte unified transmit /
>  receive buffer.
>  
>  Required properties:
> - - compatible: should be "amlogic,meson6-spifc"
> + - compatible: should be "amlogic,meson6-spifc" or "amlogic,meson-gxbb-spifc"

If you are going to use both, make sure the order is clear (most 
specific, best match first). Sometimes the chip names make that clear, 
but not here.

>   - reg: physical base address and length of the controller registers
>   - clocks: phandle of the input clock for the baud rate generator
>   - #address-cells: should be 1
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
