From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 20 Jun 2013 19:21:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA2LzZdIEFSTTogZHRzOiBBZGQgZGV2aWNlIHRyZWUgc3Vw?=
 =?UTF-8?B?cG9ydCBmb3IgcGh5Y2FyZCBwY2ExMDA=?=
In-Reply-To: <1371739815-6666-7-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-7-git-send-email-mpa@pengutronix.de>
Message-ID: <1371741670.186508416@f66.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Based on patches from:
> 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>:
>  - Original patch
>  - ARM: dts: Set partition offsets for phycard
>  - ARM: dts: Use CSPI1 instead of CSPI2 on phycard pca100
>  - ARM: imx27-phytec-phycard-S.dts: resize nand partitions
> 
> Jan Luebbe <jlu@pengutronix.de>:
>  - ARM: dts: Enable bad block table in NAND
> 
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
...
> +			gpio at 10015000 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015100 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015200 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015300 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015400 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015500 {
> +				status = "okay";
> +			};

No need setup status for devices which not disabled in imx27.dts

---
