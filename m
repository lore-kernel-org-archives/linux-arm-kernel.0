From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 08 Apr 2013 21:27:25 +0200
Subject: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
In-Reply-To: <6514915.cyFSTtqpte@vostro.rjw.lan>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <5161DC9C.3020703@linaro.org> <51630115.6040205@linaro.org>
 <6514915.cyFSTtqpte@vostro.rjw.lan>
Message-ID: <51631A1D.3090705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 09:27 PM, Rafael J. Wysocki wrote:
> On Monday, April 08, 2013 07:40:37 PM Daniel Lezcano wrote:
>> On 04/07/2013 10:52 PM, Daniel Lezcano wrote:
>>> On 04/05/2013 12:31 AM, Rafael J. Wysocki wrote:
>>>> On Wednesday, April 03, 2013 02:15:20 PM Daniel Lezcano wrote:
>>>>> The start/stop_critical_timings are called from arch/x86/kernel/process.c
>>>>> in the cpu_idle loop function.
>>>>>
>>>>> Remove the ones in the cpuidle driver.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> For this one I need an ACK from Len.
>>>>
>>>> Len, any objections?
>>>
>>> Len ? ping ...
>>
>> Rafael,
>>
>> this patch is not dependent from any patch in the series, is it possible
>> you apply the patchset except this patch ?
>>
>> May be you can apply it later when Len acks it, or I can resend it, no ?
>>
>> I have a lot of code consolidation patches awaiting for this patchset to
>> be merged.
> 
> OK, I'll take the rest of your patches in this series (except for [1/9]
> which also is not depended on by anything AFAICS).

Thanks Rafael.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
