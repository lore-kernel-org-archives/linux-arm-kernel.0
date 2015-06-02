From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 2 Jun 2015 14:31:24 -0500
Subject: [PATCH 2/2] ARM: socfpga: socrates: add gpio-leds
In-Reply-To: <5568BBCB.8040605@opensource.altera.com>
References: <1432909983-19821-1-git-send-email-s.trumtrar@pengutronix.de>
 <1432909983-19821-2-git-send-email-s.trumtrar@pengutronix.de>
 <5568BBCB.8040605@opensource.altera.com>
Message-ID: <556E048C.3040903@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2015 02:19 PM, Dinh Nguyen wrote:
> On 05/29/2015 09:33 AM, Steffen Trumtrar wrote:
>> The SOCrates has three HPS LEDs that can be turned on/off via gpio.
>> Use the first one has heartbeat and add the other two as free LEDs.
>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
>> index a81f33deaa3a..019dd2fea208 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
>> @@ -30,6 +30,9 @@
>>  		device_type = "memory";
>>  		reg = <0x0 0x40000000>; /* 1GB */
>>  	};
>> +
>> +	leds: gpio-leds {
> 
> Wonder if you should just place all the led nodes under here instead of
> under the "&leds"?
> 	

patch applied as is.

Thanks,
Dinh
