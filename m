From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 31 Mar 2015 10:25:25 +0200
Subject: [PATCH 1/2] MAINTAINERS: change the Atmel audio alsa driver entry
In-Reply-To: <550A9C2B.8090506@atmel.com>
References: <1426758530-7656-1-git-send-email-nicolas.ferre@atmel.com>
 <550A9C2B.8090506@atmel.com>
Message-ID: <551A59F5.9050108@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/03/2015 10:51, Bo Shen a ?crit :
> Hi Nicolas,
>    Thanks.
> 
> On 03/19/2015 05:48 PM, Nicolas Ferre wrote:
>> I take over the the maintainship of Atmel alsa drivers from Voice.
>> Thanks for your work!
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Bo Shen <voice.shen@atmel.com>
>> Cc: Mark Brown <broonie@linaro.org>
> 
> Acked-by: Bo Shen <voice.shen@atmel.com>

Mark,

Do you want to take this patch on your side or should I take it through
the at91/arm-soc way?

Bye,


>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ddc5a8cf9a8a..679b2d0cb2d1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1751,7 +1751,7 @@ S:	Supported
>>   F:	drivers/tty/serial/atmel_serial.c
>>
>>   ATMEL Audio ALSA driver
>> -M:	Bo Shen <voice.shen@atmel.com>
>> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>>   L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
>>   S:	Supported
>>   F:	sound/soc/atmel
>>
> 
> Best Regards,
> Bo Shen
> 
> 


-- 
Nicolas Ferre
