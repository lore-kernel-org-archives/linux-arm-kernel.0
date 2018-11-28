From: aisheng.dong@nxp.com (Aisheng DONG)
Date: Wed, 28 Nov 2018 15:38:31 +0000
Subject: [PATCH V3 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
In-Reply-To: <1543398696-3140-2-git-send-email-Anson.Huang@nxp.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
 <1543398696-3140-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <AM0PR04MB421116B3A25246AB43B535F380D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> new file mode 100644
> index 0000000..d6e2353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt

This should belong to scu binding doc.

Regards
Dong Aisheng

> @@ -0,0 +1,10 @@
> +* NXP i.MX System Controller Real Time Clock
> +
> +Required properties:
> +- compatible: should be "nxp,imx8qxp-sc-rtc";
> +
> +Example:
> +
> +rtc: rtc {
> +	compatible = "nxp,imx8qxp-sc-rtc";
> +};
> --
> 2.7.4
