From: stefan@olimex.com (Stefan Mavrodiev)
Date: Thu, 17 May 2018 10:34:06 +0300
Subject: [PATCH 1/1] ARM:dts:sunxi: Add Olimex A20-SOM-EVB-eMMC board
In-Reply-To: <96201051.35560.1526541952287@email.1und1.de>
References: <1526470689-6275-1-git-send-email-stefan@olimex.com>
 <96201051.35560.1526541952287@email.1und1.de>
Message-ID: <7ad11904-be61-a459-f2be-ff37fcd02402@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2018 10:25 AM, Stefan Wahren wrote:
> Hi Stefan,
>
>> Stefan Mavrodiev <stefan@olimex.com> hat am 16. Mai 2018 um 13:38 geschrieben:
>>
>>
>> With the new rev.E of A20-SOM-EVB, there is option for 16GB eMMC.
>> Currently used card is KLMAG2GEND, wired to MMC2 slot.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm/boot/dts/Makefile                         |  1 +
>>   .../arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts | 37 ++++++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 1db91ec..7f1ee65 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -959,6 +959,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>   	sun7i-a20-m3.dtb \
>>   	sun7i-a20-mk808c.dtb \
>>   	sun7i-a20-olimex-som-evb.dtb \
>> +	sun7i-a20-olimex-som-evb-emmc.dtb \
>>   	sun7i-a20-olimex-som204-evb.dtb \
>>   	sun7i-a20-olimex-som204-evb-emmc.dtb \
>>   	sun7i-a20-olinuxino-lime.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
>> new file mode 100644
>> index 0000000..81ebc97
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Device Tree Source for A20-Olimex-SOM-EVB-eMMC Board
>> + *
>> + * Copyright (C) 2018 Olimex Ltd.
>> + *   Author: Stefan Mavrodiev <stefan@olimex.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include "sun7i-a20-olimex-som-evb.dts"
>> +
>> +/ {
>> +
>> +	model = "Olimex A20-Olimex-SOM-EVB-eMMC";
>> +	compatible = "olimex,a20-olimex-som-evb-emmc", "allwinner,sun7i-a20";
> the file Documentation/devicetree/bindings/arm/olimex.txt seems to be out of date. I cannot find any recent board compatible.
>
> Didn't checkpatch complain about it?
Yes it did. I didn't get is seriously because neither Olimex A20 based 
board is documented in the binding.
>
> Regards
> Stefan

Regards,
Stefan Mavrodiev
