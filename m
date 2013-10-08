From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 08 Oct 2013 18:01:16 +0200
Subject: [PATCH v3 12/19] clk: at91: add peripheral clk macros for
 peripheral clk dt bindings
In-Reply-To: <52542878.5050503@atmel.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
 <1375945839-9573-1-git-send-email-b.brezillon@overkiz.com>
 <52542878.5050503@atmel.com>
Message-ID: <52542C4C.5080409@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2013 17:44, Nicolas Ferre wrote:
> On 08/08/2013 09:10, Boris BREZILLON :
>> This patch adds the peripheral divisors macros (for sam9x5 compatible 
>> IPs)
>> which will be used by peripheral clk dt definitions.
>
> I am in favor for these definitions. So let's keep them (with raw 
> numbers toguether with these macros in documentation).

I guess we should move them elsewhere if these are the only macros we keep.

What about "include/dt-bindings/clk/at91sam9x5-periph.h" ?
>
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   .../clk/at91/at91sam9x5/clk-peripheral.h           |   15 
>> +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>   create mode 100644 
>> include/dt-bindings/clk/at91/at91sam9x5/clk-peripheral.h
>>
>> diff --git a/include/dt-bindings/clk/at91/at91sam9x5/clk-peripheral.h 
>> b/include/dt-bindings/clk/at91/at91sam9x5/clk-peripheral.h
>> new file mode 100644
>> index 0000000..a6dd506
>> --- /dev/null
>> +++ b/include/dt-bindings/clk/at91/at91sam9x5/clk-peripheral.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * This header provides constants for AT91 peripheral clks.
>> + *
>> + * The constants defined in this header are being used in dts.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_AT91SAM9X5_PERIPH_H
>> +#define _DT_BINDINGS_CLK_AT91SAM9X5_PERIPH_H
>> +
>> +#define AT91SAM9X5_PERIPH_CLK_DIV1    0
>> +#define AT91SAM9X5_PERIPH_CLK_DIV2    1
>> +#define AT91SAM9X5_PERIPH_CLK_DIV4    2
>> +#define AT91SAM9X5_PERIPH_CLK_DIV8    3
>> +
>> +#endif
>>
>
>
