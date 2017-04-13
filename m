From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 13 Apr 2017 18:09:56 -0300
Subject: [PATCH v2 05/22] ARM: dts: at91: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <869a0f44-6c97-2109-776b-6da9b86c732a@axentia.se>
References: <20170413182839.25381-1-javier@osg.samsung.com>
 <20170413182839.25381-6-javier@osg.samsung.com>
 <869a0f44-6c97-2109-776b-6da9b86c732a@axentia.se>
Message-ID: <dd93eb32-ca1e-5041-051e-c4f072f0f9a2@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On 04/13/2017 05:43 PM, Peter Rosin wrote:
> On 2017-04-13 20:28, Javier Martinez Canillas wrote:

[snip]

>>  
>>  	eeprom at 50 {
>> -		compatible = "nxp,24c02";
>> +		compatible = "nxp,24c02","atmel,24c02";
>>  		reg = <0x50>;
>>  		pagesize = <16>;
>>  	};
>>
> 
> Sure, in principle. But not having a space after the commas is a real OCD
> trigger for me. My spine is rotating... :-)
>

Right, Geert already pointed out. It's something I missed in my sed script
so I got it wrong in all the DTS :(

I'll fix my script and send a v2.
 
> Anyway, with those whitespace fixes (and without them too, but please):
> Acked-by: Peter Rosin <peda@axentia.se>
>

Thanks for the review!

> Cheers,
> peda
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
