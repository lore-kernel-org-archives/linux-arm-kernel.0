From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 22 May 2014 20:57:43 +0200
Subject: [PATCH V5 00/20] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle
In-Reply-To: <537E438C.8060600@samsung.com>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
 <534BA3CF.6030701@linaro.org> <535943B2.8030308@samsung.com>
 <0b4201cf613f$80c91750$825b45f0$@samsung.com> <537E438C.8060600@samsung.com>
Message-ID: <537E48A7.1060904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 08:35 PM, Kukjin Kim wrote:
> On 04/26/14 20:05, Kukjin Kim wrote:
>> Tomasz Figa wrote:
>>>
>>> On 14.04.2014 11:01, Daniel Lezcano wrote:
>>>>
>>>> Hi Kukjin,
>>>>
>>>> I believe I addressed all the comments. Is it possible to take this
>>>> patchset for next ?
>>>
>> Sure ;-)
>>
>>> +1.
>>>
>>> Also when applying you might add
>>>
>>> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>>>
>>> to any patches that don't have it yet.
>>>
>> Tomasz, thanks for your review.
>>
>> I will take this series, "moving exynos-cpuidle into drivers/cpuidle"
>> into samsung tree if Rafael is OK on that.
>>
> Daniel,
>
> Can you please check/test the functionality your series with using my
> for-next because there were merge conflicts with mcpm-exynos stuff...?

Sure, will do that tomorrow.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
