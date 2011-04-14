From: b32955@freescale.com (Huang Shijie)
Date: Thu, 14 Apr 2011 14:36:36 +0800
Subject: [PATCH v5 2/4] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <19878.37657.263254.506346@ipc1.ka-ro>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>	<1302675881-18862-3-git-send-email-b32955@freescale.com>
	<19878.37657.263254.506346@ipc1.ka-ro>
Message-ID: <4DA695F4.5040108@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> Hi,
>
> Huang Shijie writes:
>> These files contain the common code for the GPMI driver.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c | 2502 +++++++++++++++++++++++++++++
>>   drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h      |  488 ++++++
>>   2 files changed, 2990 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
>>   create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
>>
>> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
>> new file mode 100644
>> index 0000000..33d9f2d
>> --- /dev/null
>> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
>> @@ -0,0 +1,2502 @@
> [...]
>> +static const struct platform_device_id gpmi_ids[] = {
>> +	{
>> +		.name = GPMI_NFC_DRIVER_MX23,
>> +		.driver_data = IS_MX23,
>> +	}, {
>> +		.name = GPMI_NFC_DRIVER_MX28,
>> +		.driver_data = IS_MX28,
>> +	}
>> +};
>>
> An empty entry as end of list marker is missing.
>
thanks.

Huang Shijie
> Lothar Wa?mann
