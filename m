From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 13 Oct 2015 22:16:19 +0200
Subject: [PATCH v4 20/26] ARM: pxa: magician: Add support for MAX1587A
 Vcore regulator
In-Reply-To: <1443877066.4186.38.camel@gmail.com> (Philipp Zabel's message of
 "Sat, 03 Oct 2015 14:57:46 +0200")
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B377.3020404@tul.cz>
 <1443877066.4186.38.camel@gmail.com>
Message-ID: <87k2qq4j8s.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

>> +static struct regulator_init_data magician_max1587a_v3_info = {
>> +	.constraints = {
>> +		.name		= "vcc_core range",
>> +		.min_uV		= 700000,
>> +		.max_uV		= 1500000,
>
> Wouldn't that be 1475000 for MAX1587A without the R24 resistor?
That is what I read in the Maxim 1587A datasheet, so squashed this into the
patch and queued into pxa/for-next.

Thanks.

-- 
Robert
