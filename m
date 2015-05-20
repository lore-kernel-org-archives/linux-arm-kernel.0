From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 20 May 2015 14:46:23 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9x5: fix usart1 sck pin definition
In-Reply-To: <20150520124154.GB3907@piout.net>
References: <1432125370-21092-1-git-send-email-nicolas.ferre@atmel.com>
 <20150520124154.GB3907@piout.net>
Message-ID: <555C821F.7090104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/05/2015 14:41, Alexandre Belloni a ?crit :
> On 20/05/2015 at 14:36:10 +0200, Nicolas Ferre wrote :
>> SCK1 pin is pioC 29. Comment was okay.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index 9c236c317eeb..dfdbdf43860e 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -505,7 +505,7 @@
>>  
>>  					pinctrl_usart1_sck: usart1_sck-0 {
>>  						atmel,pins =
>> -							<AT91_PIOC 28 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC29 periph C */
>> +							<AT91_PIOC 29 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC29 periph C */
> 
> I think you should remove the comment. As you can see, it didn't help ;)

I agree, but didn't do it in this patch because the whole file is
stuffed with these useless comments... We'd better do it in a single
patch or... leave it like this...

Bye,

>>  					};
>>  				};
>>  
>> -- 
>> 2.1.3
>>
> 


-- 
Nicolas Ferre
