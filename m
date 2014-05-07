From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 07 May 2014 08:46:12 +0200
Subject: [linux-sunxi] [PATCH 7/7] ARM: sunxi: dt: add APP4-EVB1 board
 support
In-Reply-To: <EEF98E4B-881E-469C-A1C7-8B4EB8825467@dominion.thruhere.net>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-8-git-send-email-maxime.ripard@free-electrons.com>
 <EEF98E4B-881E-469C-A1C7-8B4EB8825467@dominion.thruhere.net>
Message-ID: <5369D6B4.3080305@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/07/2014 07:10 AM, Koen Kooi wrote:
> 
> Op 7 mei 2014, om 05:50 heeft Maxime Ripard <maxime.ripard@free-electrons.com> het volgende geschreven:
> 
>> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
>>
>> The APP4 EVB1 development boards embeds an A31, together with some NAND, one SD
>> card slot, and one SDIO + UART WiFi and Bluetooth chip, a few I2C buses, USB,
>> and a LCD display.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>> arch/arm/boot/dts/Makefile                |  1 +
>> arch/arm/boot/dts/sun6i-a31-app4-evb1.dts | 63 +++++++++++++++++++++++++++++++
>> 2 files changed, 64 insertions(+)
>> create mode 100644 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ffa3f5ef27d3..d50c0895a9d5 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -343,6 +343,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
>> 	sun5i-a10s-olinuxino-micro.dtb \
>> 	sun5i-a13-olinuxino.dtb \
>> 	sun5i-a13-olinuxino-micro.dtb \
>> +	sun6i-a31-app4-evb1.dtb \
>> 	sun6i-a31-colombus.dtb \
>> 	sun6i-a31-m9.dtb \
>> 	sun7i-a20-cubieboard2.dtb \
>> diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
>> new file mode 100644
>> index 000000000000..270ab978f858
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Copyright 2014 Boris Brezillon
>> + *
>> + * Boris Brezillon <boris.brezillon@free-electrons.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
> 
> Doesn't the kernel try to avoid the 'or later' clause?

The kernel as a whole is just "version 2", but for individual files /
drivers it is left up to the author whether to add "or later " or not.

Regards,

Hans
