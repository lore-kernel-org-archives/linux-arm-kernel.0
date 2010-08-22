From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 22 Aug 2010 10:24:59 +0300
Subject: [PATCH v2] ARM: imx: fix build failure concerning otg/ulpi
In-Reply-To: <4C68D607.3090202@compulab.co.il>
References: <4C65246E.1000906@ru.mvista.com>	<1281701210-27776-1-git-send-email-u.kleine-koenig@pengutronix.de>	<4C6783C7.1030604@compulab.co.il>	<20100816045340.GA17038@pengutronix.de>
	<4C68D607.3090202@compulab.co.il>
Message-ID: <4C70D0CB.6040903@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Greg,

ping...

On 08/16/10 09:09, Igor Grinberg wrote:
> On 08/16/10 07:53, Uwe Kleine-K?nig wrote:
>> Hello Igor,
>>
>> On Sun, Aug 15, 2010 at 09:05:59AM +0300, Igor Grinberg wrote:
>>   
>>> On 08/13/10 15:06, Uwe Kleine-K?nig wrote:
>>>     
>>>> The build failure was introduced by
>>>>
>>>> 	13dd0c9 (USB: otg/ulpi: extend the generic ulpi driver.)
>>>>
>>>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>>>> Cc: Mike Rapoport <mike@compulab.co.il>
>>>> Cc: Greg Kroah-Hartman <gregkh@suse.de>
>>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>>>   
>>>>       
>>> I've based my patches on v2.6.35-rc6, so I could not patch
>>> those imx variants, sorry...
>>> But I did deal with mach-pca100.c, so I think moving it from
>>> mach-mx2 to mach-imx is what made it miss my patch.
>>>
>>> Anyway, this looks like the right addition.
>>>     
>> I assume this is an Ack?
>>   
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
>
>
> Greg,
>
> Can you, please, add this as a fix (maybe urgent) for build failure?
>
> Thanks
>
>> Best regards
>> Uwe
>>
>>   

-- 
Regards,
Igor.
