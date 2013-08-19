From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 19 Aug 2013 18:45:02 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzddIHBpbmN0cmw6IGlteDI3OiBpbXgyNyBwaW5j?=
 =?UTF-8?B?b250cm9sIGRyaXZlcg==?=
In-Reply-To: <1376921234-26682-3-git-send-email-mpa@pengutronix.de>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
 <1376921234-26682-3-git-send-email-mpa@pengutronix.de>
Message-ID: <1376923502.112235348@f25.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> imx27 pincontrol driver using the imx1 core driver. The DT bindings are
> similar to other imx pincontrol drivers.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
[...]
> diff --git a/drivers/pinctrl/pinctrl-imx27.c b/drivers/pinctrl/pinctrl-imx27.c
[...]
> +	MX27_PAD_ATA_DATA15 = PAD_ID(PF, 23),
> +	MX27_PAD_UNUSED15 = PAD_ID(PF, 24),
> +	MX27_PAD_UNUSED16 = PAD_ID(PF, 25),
> +	MX27_PAD_UNUSED17 = PAD_ID(PF, 26),
> +	MX27_PAD_UNUSED18 = PAD_ID(PF, 27),
> +	MX27_PAD_UNUSED19 = PAD_ID(PF, 28),
> +	MX27_PAD_UNUSED20 = PAD_ID(PF, 29),
> +	MX27_PAD_UNUSED21 = PAD_ID(PF, 30),
> +	MX27_PAD_UNUSED22 = PAD_ID(PF, 31),

No PF24-PF31 pads in CPU.
Is it worth it to have these definitions?

---
