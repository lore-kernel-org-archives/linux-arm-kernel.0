From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 7 Dec 2017 14:11:01 +0100
Subject: [PATCH v2 4/8] clocksource: owl: Prepare S700
In-Reply-To: <95e19098-e7a0-424e-3970-5c391605c059@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
 <20171113233427.5386-5-afaerber@suse.de>
 <ca3caff7-996e-a08d-4d4e-2cf239929535@suse.de>
 <126e159d-76db-8249-6844-d2a968c4a083@linaro.org>
 <95e19098-e7a0-424e-3970-5c391605c059@suse.de>
Message-ID: <f1480e8b-81b8-e425-794a-abbe77387877@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2017 13:47, Andreas F?rber wrote:
> Am 07.12.2017 um 10:23 schrieb Daniel Lezcano:
>> On 05/12/2017 00:00, Andreas F?rber wrote:
>>> Hi Daniel,
>>>
>>> Am 14.11.2017 um 00:34 schrieb Andreas F?rber:
>>>> Actions S700 has two 2Hz timers like S500, and four TIMx timers like S900.
>>>>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>>  v1 -> v2:
>>>>  * Adopted TIMER_OF_DECLARE() (Daniel)
>>>>  
>>>>  drivers/clocksource/owl-timer.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>
>>> Are you planning to queue this v2 patch for 4.16?
>>
>> Yeah, what about the patch 1/8 ?
> 
> In linux-next already.

Yeah, but that does not mean the patch is merged. Do you mean it is
merged in arm-soc, so it is visible in linux-next?

> If you take 2-4, I can take 5; if you'd rather have me take the binding,
> fine with me as well.

I will take patches 2-4.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
