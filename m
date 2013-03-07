From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 07 Mar 2013 19:15:26 +0100
Subject: [PATCH] ARM: sunxi: dt: Add support for the Miniand Mini X-plus
In-Reply-To: <51386777.5040109@geeks.cl>
References: <1362583127-25726-1-git-send-email-maxime.ripard@free-electrons.com>
 <51386777.5040109@geeks.cl>
Message-ID: <5138D93E.6040607@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alejandro,

Le 07/03/2013 11:09, Alejandro Mery a ?crit :
> 
> On 06/03/13 16:18, Maxime Ripard wrote:
>> This board comes with an Allwinner A10, two external USB ports, a SD
>> Card reader, 1GB of RAM, the usual video connectors and an onboard wifi
>> chip.
>>
>> Of course, the support is quite minimal for now...
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>   arch/arm/boot/dts/sun4i-a10-mini-xplus.dts |   30
>> ++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
>> b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
>> new file mode 100644
>> index 0000000..635e135
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Copyright 2012 Maxime Ripard
>> + *
>> + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "sun4i-a10.dtsi"
>> +
>> +/ {
>> +    model = "Miniand Mini X-Plus";
>> +    compatible = "miniand,mini-xplus", "allwinner,sun4i-a10";
> 
> Hi, I just wanted to mention that Miniand is just a reseller. This
> device is made by PineRiver <http://pineriver.cn/> and most commonly
> available rebranded by "Jesurun" than miniand.

Thanks, I'll fix it.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
