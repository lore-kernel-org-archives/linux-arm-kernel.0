From: b32955@freescale.com (Huang Shijie)
Date: Mon, 11 Jul 2011 13:16:33 +0800
Subject: [PATCH v6 1/4] ARM: mxs: add GPMI-NAND support for imx23/imx28
In-Reply-To: <20110708190722.GA16490@pengutronix.de>
References: <1310102885-4102-1-git-send-email-b32955@freescale.com>
	<1310102885-4102-2-git-send-email-b32955@freescale.com>
	<20110708190722.GA16490@pengutronix.de>
Message-ID: <4E1A8731.9080708@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> Hi Huang,
>
>> diff --git a/arch/arm/mach-mxs/include/mach/gpmi-nand.h b/arch/arm/mach-mxs/include/mach/gpmi-nand.h
>> new file mode 100644
>> index 0000000..f1cf565
>> --- /dev/null
>> +++ b/arch/arm/mach-mxs/include/mach/gpmi-nand.h
> I am also mostly happy with it now :)
>
> Assuming the above file will be needed by mx50/mx6, too, would it make sense to
> put it to include/linux/mtd/gpmi-nand.h right from the beginning?
thanks.

A good idea.

Best Regards
Huang Shijie
> Regards,
>
>    Wolfram
>
