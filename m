From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 14 Apr 2011 08:24:25 +0200
Subject: [PATCH v5 2/4] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <1302675881-18862-3-git-send-email-b32955@freescale.com>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-3-git-send-email-b32955@freescale.com>
Message-ID: <19878.37657.263254.506346@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> These files contain the common code for the GPMI driver.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c | 2502 +++++++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h      |  488 ++++++
>  2 files changed, 2990 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
> 
> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
> new file mode 100644
> index 0000000..33d9f2d
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
> @@ -0,0 +1,2502 @@
[...]
> +static const struct platform_device_id gpmi_ids[] = {
> +	{
> +		.name = GPMI_NFC_DRIVER_MX23,
> +		.driver_data = IS_MX23,
> +	}, {
> +		.name = GPMI_NFC_DRIVER_MX28,
> +		.driver_data = IS_MX28,
> +	}
> +};
>
An empty entry as end of list marker is missing.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
