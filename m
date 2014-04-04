From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 04 Apr 2014 11:16:08 +0200
Subject: [PATCH 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <CAKohpo=Dbp1uSCpOMhAx5vk9ddYP=DK14Od6_aoAuyX3mrwzew@mail.gmail.com>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>	<1396597683-6969-18-git-send-email-daniel.lezcano@linaro.org>
 <CAKohpo=Dbp1uSCpOMhAx5vk9ddYP=DK14Od6_aoAuyX3mrwzew@mail.gmail.com>
Message-ID: <533E7858.2030403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 11:10 AM, Viresh Kumar wrote:
> On 4 April 2014 13:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> The cpuidle driver is broken since v3.11 and now we are at v3.14.
>>
>> Default the cpuidle driver to favorize a better detection next time.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/configs/exynos_defconfig |    1 +
>>   1 file changed, 1 insertion(+)
>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks Viresh for the review !


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
