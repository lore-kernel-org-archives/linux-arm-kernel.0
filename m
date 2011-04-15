From: b32955@freescale.com (Huang Shijie)
Date: Fri, 15 Apr 2011 16:13:43 +0800
Subject: [PATCH 1/2] ARM: mxs: add GPMI support for imx23/imx28
In-Reply-To: <20110415080621.GL31990@pengutronix.de>
References: <1302854508-13652-1-git-send-email-b32955@freescale.com>
	<20110415080621.GL31990@pengutronix.de>
Message-ID: <4DA7FE37.7030808@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Apr 15, 2011 at 04:01:47PM +0800, Huang Shijie wrote:
>> +#define GPMI_NFC_DRIVER_NAME	"gpmi-nfc"
>> +#define GPMI_NFC_DRIVER_MX23	"imx23-gpmi-nfc"
>> +#define GPMI_NFC_DRIVER_MX28	"imx28-gpmi-nfc"
>> +#define GPMI_NFC_DRIVER_MX50	"imx50-gpmi-nfc"
> Is it sensible to keep these when they are only used in a single .c
> file?
>
I also use these in gpmi driver for distinguish platform id.
Do i have to remove these lines , and use the hardcode?
