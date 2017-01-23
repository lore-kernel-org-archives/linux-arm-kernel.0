From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 23 Jan 2017 18:20:51 +0100
Subject: [PATCH v2 9/9] Documentation: DT: add entries for I2SE boards
In-Reply-To: <1485123764-14754-10-git-send-email-mhei@heimpold.de>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
 <1485123764-14754-10-git-send-email-mhei@heimpold.de>
Message-ID: <189e072d-50b8-796c-c27b-5d77cc6dd12c@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.01.2017 um 23:22 schrieb Michael Heimpold:
> This patch adds the missing devicetree binding documentation for I2SE's
> Duckbill and Duckbill 2 series boards.
>
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/arm/i2se.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/i2se.txt b/Documentation/devicetree/bindings/arm/i2se.txt
> new file mode 100644
> index 0000000..9f30382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/i2se.txt
> @@ -0,0 +1,22 @@
> +I2SE Device Tree Bindings
> +-------------------------
> +
> +Duckbill Board
> +Required root node properties:
> +    - compatible = "i2se,duckbill", "fsl.imx28";
> +
> +Duckbill 2 Board
> +Required root node properties:
> +    - compatible = "i2se,duckbill", "fsl.imx28";
> +
> +Duckbill 2 485 Board
> +Required root node properties:
> +    - compatible = "i2se,duckbill", "fsl.imx28";
> +
> +Duckbill 2 EnOcean Board
> +Required root node properties:
> +    - compatible = "i2se,duckbill", "fsl.imx28";
> +
> +Duckbill 2 SPI Board
> +Required root node properties:
> +    - compatible = "i2se,duckbill", "fsl.imx28";

Please replace all fsl.imx28 with fsl,imx28

Maybe this patch should come before adding the Duckbill 2 board dts files.
