From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Mon, 3 Sep 2018 09:54:08 +0000
Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
In-Reply-To: <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Yogesh,

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org <linux-kernel-
> owner at vger.kernel.org> On Behalf Of Yogesh Gaur
> Sent: Friday, August 31, 2018 4:00 PM
> To: linux-mtd at lists.infradead.org; boris.brezillon at bootlin.com;
> marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> devicetree at vger.kernel.org
> Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; linux-
> arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI driver
> 
> Add binding file for NXP FlexSPI driver.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> fspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 0000000..9f07116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -0,0 +1,42 @@
> +* NXP Flex Serial Peripheral Interface (FSPI)
> +
> +Required properties:
> +  - compatible : Should be "nxp,lx2160a-fspi"
> +  - reg :        First contains the register location and length,
> +                 Second contains the memory mapping address and length

Why are we overriding reg property.  Is there any special requirement. 

Can we use "reg" and "ranges" property in device tree.
Here "reg" represents controller registers and "ranges" represent the memory address of flash.

--pk
