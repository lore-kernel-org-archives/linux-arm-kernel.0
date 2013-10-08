From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 08 Oct 2013 14:03:56 +0200
Subject: [PATCH v3 07/19] clk: at91: add pll id macros for pll dt bindings
In-Reply-To: <5253DEBD.7010904@atmel.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
 <1375942160-8881-1-git-send-email-b.brezillon@overkiz.com>
 <5253DEBD.7010904@atmel.com>
Message-ID: <5253F4AC.8050407@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2013 12:30, Nicolas Ferre wrote:
> On 08/08/2013 08:09, Boris BREZILLON :
>> This patch adds the PLL id macros which will be used by pll dt 
>> definitions.
>
> It is not needed, drop it. Just document the values in the DT biding 
> and it will be fine.

I'll drop (and document) it.

>
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   include/dt-bindings/clk/at91/common/clk-pll.h |   13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>   create mode 100644 include/dt-bindings/clk/at91/common/clk-pll.h
>>
>> diff --git a/include/dt-bindings/clk/at91/common/clk-pll.h 
>> b/include/dt-bindings/clk/at91/common/clk-pll.h
>> new file mode 100644
>> index 0000000..93ec849
>> --- /dev/null
>> +++ b/include/dt-bindings/clk/at91/common/clk-pll.h
>> @@ -0,0 +1,13 @@
>> +/*
>> + * This header provides constants for AT91 pll ids.
>> + *
>> + * The constants defined in this header are being used in dts.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_AT91_PLL_H
>> +#define _DT_BINDINGS_CLK_AT91_PLL_H
>> +
>> +#define AT91_PLLA_CLK        0    /* PLLA clk id */
>> +#define AT91_PLLB_CLK        1    /* PLLB clk id */
>> +
>> +#endif
>>
>
>
