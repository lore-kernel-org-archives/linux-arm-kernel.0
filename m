From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Oct 2014 16:50:14 +0200
Subject: [PATCH 1/2] MAINTAINERS: add atmel ssc driver maintainer entry
In-Reply-To: <54291A0C.3090206@atmel.com>
References: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
 <54291A0C.3090206@atmel.com>
Message-ID: <544672A6.9090101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/2014 10:36, Nicolas Ferre :
> On 28/09/2014 03:57, Bo Shen :
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> 
> Sure:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks.

Greg or Arnd,

This MAINTAINER's update didn't make it during merge window (on the
other hand, I didn't build a pull-request with it neither...).

Do you want that I take it in one of my "fixes" pull-requests to arm-soc
for 3.18 or do you feel like taking the patch directly? I think it makes
sense to not wait for the 3.19 for this kind of useful information.

Thanks, bye,


>> ---
>>
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3705430..c004e6f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1703,6 +1703,13 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>>  S:	Supported
>>  F:	drivers/spi/spi-atmel.*
>>  
>> +ATMEL SSC DRIVER
>> +M:	Bo Shen <voice.shen@atmel.com>
>> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> +S:	Supported
>> +F:	drivers/misc/atmel-ssc.c
>> +F:	include/linux/atmel-ssc.h
>> +
>>  ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
>>  M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>
> 
> 


-- 
Nicolas Ferre
