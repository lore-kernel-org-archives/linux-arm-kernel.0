From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 Jan 2017 21:32:31 -0300
Subject: [PATCH] usb: dwc3-exynos fix axius clock error path to do cleanup
In-Reply-To: <c1938cd9-9bcf-d28b-48fd-be6a22a1f3f7@osg.samsung.com>
References: <20170110230528.7612-1-shuahkh@osg.samsung.com>
 <e4f0b77a-d827-08fa-c4f6-950197c54358@osg.samsung.com>
 <c1938cd9-9bcf-d28b-48fd-be6a22a1f3f7@osg.samsung.com>
Message-ID: <006ab225-6e16-b1d7-567c-d1f236702589@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On 01/10/2017 09:30 PM, Shuah Khan wrote:

[snip]

>>>  	clk_disable_unprepare(exynos->axius_clk);
>>> +axius_clk_err:
>>
>> This label isn't consistent with the others, I know the errN aren't great
>> so what about changing those to meaningful names in a preparatory patch?
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> Best regards,
>>
> 
> Javier,
> 
> Right they aren't consistent. Changing them all to a better naming scheme
> will have be done in another cleanup patch in my opinion. I don't want to
> include cleanup in this fix.
>

I didn't mean to be done in the same patch, that's why I said in another
preparatory patch.
 
> thanks,
> -- Shuah
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
