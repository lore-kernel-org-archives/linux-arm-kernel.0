From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 25 Mar 2013 15:11:50 +0100
Subject: [PATCH] ARM: at91: add Acme Systems Aria G25 board
In-Reply-To: <20130325122220.GF2001@game.jcrosoft.org>
References: <1364201369-12047-1-git-send-email-nicolas.ferre@atmel.com>
 <20130325122220.GF2001@game.jcrosoft.org>
Message-ID: <51505B26.7040508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 01:22 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 09:49 Mon 25 Mar     , Nicolas Ferre wrote:
>> From: Douglas Gilbert <dgilbert@interlog.com>
>>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/boot/dts/ariag25.dts | 168 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 168 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/ariag25.dts
>>
>> diff --git a/arch/arm/boot/dts/ariag25.dts b/arch/arm/boot/dts/ariag25.dts
>> new file mode 100644
>> index 0000000..d18ef50
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/ariag25.dts
>> @@ -0,0 +1,168 @@
>> +/*
>> + * ariag25.dts - Device Tree file for Acme Systems Aria G25 (AT91SAM9G25 based)
>> + *
>> + * Copyright (C) 2013 Douglas Gilbert <dgilbert@interlog.com>,
>> + *                    Robert Nelson <robertcnelson@gmail.com>
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +/dts-v1/;
>> +/include/ "at91sam9g25.dtsi"
>> +
>> +/ {
>> +	model = "Acme Systems Aria G25";
>> +	compatible = "acme,ariag25", "atmel,at91sam9g25ek", "atmel,at91sam9x5ek",
>> +		     "atmel,at91sam9x5", "atmel,at91sam9";
> I doube the code is compatible with the 9g25ek
> 
> specially when you do not include it

Ok, I remove it.

>> +
>> +	aliases {
>> +		serial4 = &usart3;
>> +		serial5 = &uart0;
>> +	};
> you need to specify all

Well I do not think so: other are taken from

/include/ "at91sam9g25.dtsi"

Bye,
-- 
Nicolas Ferre
