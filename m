From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 7 Dec 2017 10:23:12 +0100
Subject: [PATCH v2 4/8] clocksource: owl: Prepare S700
In-Reply-To: <ca3caff7-996e-a08d-4d4e-2cf239929535@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
 <20171113233427.5386-5-afaerber@suse.de>
 <ca3caff7-996e-a08d-4d4e-2cf239929535@suse.de>
Message-ID: <126e159d-76db-8249-6844-d2a968c4a083@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 00:00, Andreas F?rber wrote:
> Hi Daniel,
> 
> Am 14.11.2017 um 00:34 schrieb Andreas F?rber:
>> Actions S700 has two 2Hz timers like S500, and four TIMx timers like S900.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v1 -> v2:
>>  * Adopted TIMER_OF_DECLARE() (Daniel)
>>  
>>  drivers/clocksource/owl-timer.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Are you planning to queue this v2 patch for 4.16?

Yeah, what about the patch 1/8 ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
