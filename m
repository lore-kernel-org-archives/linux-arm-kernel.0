From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 10 Mar 2013 22:55:26 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxMC8xMF0gQVNvQzogaW14LXNzaTogQWRkIGlteDI3IGFu?=
 =?UTF-8?B?ZCBwY2ExMDAgRFQgc3VwcG9ydA==?=
In-Reply-To: <1362940391-8338-11-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-11-git-send-email-mpa@pengutronix.de>
Message-ID: <1362941726.17062673@f71.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> Add devicetree bindings for generic imx-ssi support and specifically for
> pca100 with two custom reset functions. At the moment those functions
> are defined in mach-pca100.c. So until DT is the only method for
> booting, the ac97 reset functions have to be exported in mach-pca100.c.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
...
> +		if (of_property_read_bool(pdev->dev.of_node, "imx-ssi-net"))
> +			ssi->flags |= IMX_SSI_NET;

This line does not make sense until the patch is not applied:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/106482.html

---
