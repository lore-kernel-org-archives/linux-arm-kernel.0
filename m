From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Nov 2009 10:54:58 +0100
Subject: [PATCH 16/25] imx: generalize nand device registration
In-Reply-To: <1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091117095458.GA7407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> +#define imx21_add_mxc_nand(pdata) imx_add_mxc_nand(MX21_NFC_BASE_ADDR, MX21_INT_NFC, pdata)
> +#define imx25_add_mxc_nand(pdata) imx_add_mxc_nand(MX25_NFC_BASE_ADDR, MX25_INT_NFC, pdata)
> +#define imx27_add_mxc_nand(pdata) imx_add_mxc_nand(MX27_NFC_BASE_ADDR, MX27_INT_NFC, pdata)
> +#define imx31_add_mxc_nand(pdata) imx_add_mxc_nand(MX31_NFC_BASE_ADDR, MX31_INT_NFC, pdata)
> +#define imx35_add_mxc_nand(pdata) imx_add_mxc_nand(MX35_NFC_BASE_ADDR, MX35_INT_NFC, pdata)
Here a s/_INT_NFC/_INT_NANDFC/ is needed for all five macros.  Already
fixed in my tree.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
