From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 4 Oct 2018 20:37:35 +0200
Subject: [PATCH 2/2] dt-bindings: rtc: Add ASPEED description
In-Reply-To: <20181003133155.27494-3-joel@jms.id.au>
References: <20181003133155.27494-1-joel@jms.id.au>
 <20181003133155.27494-3-joel@jms.id.au>
Message-ID: <20181004183735.GB5626@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think this patch should come first.

On 03/10/2018 15:31:55+0200, Joel Stanley wrote:
> Describe the RTC as used in the ASPEED ast2400 and ast2500 SoCs.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/rtc/rtc-aspeed.txt     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> new file mode 100644
> index 000000000000..d31a4d24c75f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> @@ -0,0 +1,18 @@
> +ASPEED BMC RTC
> +==============
> +
> +Required properties:
> + - compatible: should be one of the following
> +   * aspeed,ast2400-rtc for the ast2400
> +   * aspeed,ast2500-rtc for the ast2500
> +
> + - reg: physical base address of the controller and length of memory mapped
> +   region
> +
> +Example:
> +
> +   rtc at 1e781000 {
> +           compatible = "aspeed,ast2400-rtc";
> +           reg = <0x1e781000 0x18>;
> +           status = "disabled";
> +   };
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
