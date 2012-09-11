From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 14:15:18 +0200
Subject: [PATCH] ASoC: atmel-ssc: include linux/io.h for raw io
In-Reply-To: <503B2951.3010508@atmel.com>
References: <20120823152324.GI7995@opensource.wolfsonmicro.com>
 <1345738494-4014-1-git-send-email-nicolas.ferre@atmel.com>
 <20120825202515.GF6520@opensource.wolfsonmicro.com>
 <503B2951.3010508@atmel.com>
Message-ID: <504F2B56.6020809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2012 10:01 AM, Nicolas Ferre :
> On 08/25/2012 10:25 PM, Mark Brown :
>> On Thu, Aug 23, 2012 at 06:14:54PM +0200, Nicolas Ferre wrote:
>>> From: Joachim Eastwood <manabian@gmail.com>
>>>
>>> Include linux/io.h for raw io operations in atmel-scc header.
>>>
>>> This fixes the following build error:
>>>   CC [M]  sound/soc/atmel/atmel_ssc_dai.o
>>> sound/soc/atmel/atmel_ssc_dai.c: In function 'atmel_ssc_interrupt':
>>> sound/soc/atmel/atmel_ssc_dai.c:171: error: implicit declaration of function '__raw_readl'
>>> sound/soc/atmel/atmel_ssc_dai.c: In function 'atmel_ssc_shutdown':
>>> sound/soc/atmel/atmel_ssc_dai.c:249: error: implicit declaration of function '__raw_writel'
>>
>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>> but why not just apply it to the ASoC tree?
> 
> Fine by me then: so Mark, can you take it for a 3.6 fixes branch?
> 
> (I remove it from my at91-fixes branch that will go through arm-soc tree).

Hi Mark,

Ping?

Best regards,
-- 
Nicolas Ferre
