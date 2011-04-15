From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Apr 2011 10:06:21 +0200
Subject: [PATCH 1/2] ARM: mxs: add GPMI support for imx23/imx28
In-Reply-To: <1302854508-13652-1-git-send-email-b32955@freescale.com>
References: <1302854508-13652-1-git-send-email-b32955@freescale.com>
Message-ID: <20110415080621.GL31990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 04:01:47PM +0800, Huang Shijie wrote:
> +#define GPMI_NFC_DRIVER_NAME	"gpmi-nfc"
> +#define GPMI_NFC_DRIVER_MX23	"imx23-gpmi-nfc"
> +#define GPMI_NFC_DRIVER_MX28	"imx28-gpmi-nfc"
> +#define GPMI_NFC_DRIVER_MX50	"imx50-gpmi-nfc"
Is it sensible to keep these when they are only used in a single .c
file?

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
