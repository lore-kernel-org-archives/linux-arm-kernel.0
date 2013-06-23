From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 23 Jun 2013 12:54:34 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzVdIEFSTTogZHRzOiBpbXgyNzogQWRkIDEtd2ly?=
 =?UTF-8?B?ZQ==?=
In-Reply-To: <1371977061-9891-4-git-send-email-mpa@pengutronix.de>
References: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
 <1371977061-9891-4-git-send-email-mpa@pengutronix.de>
Message-ID: <1371977674.224117544@f196.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
...
> +			owire: owire at 10009000 {
> +				compatible = "fsl,imx27-owire", "fsl,imx21-owire";
> +				reg = <0x10009000 0x1000>;
> +				clocks = <&clks 35>;
> +				clock-names = "ipg";

Clock name can be discarded here.

> +				status = "disabled";
> +			};
> +


---
