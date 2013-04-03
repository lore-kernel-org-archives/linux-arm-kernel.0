From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Apr 2013 14:09:55 +0200
Subject: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
In-Reply-To: <1364988239.16957.78.camel@jlo-ubuntu-64.nvidia.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
 <5155BB27.4000405@wwwdotorg.org> <515C101F.1020801@linaro.org>
 <1364988239.16957.78.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <515C1C13.801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 01:23 PM, Joseph Lo wrote:
> On Wed, 2013-04-03 at 19:18 +0800, Daniel Lezcano wrote:
>> On 03/29/2013 05:02 PM, Stephen Warren wrote:
>>> On 03/29/2013 04:31 AM, Daniel Lezcano wrote:
>>>> Initialize the idle states directly in the driver structure.
>>>>
>>>> That prevents extra structure declaration and memcpy at init time.
>>>
>>> Joseph, can you please review/ack patch 5/9 and patch 6/9. Thanks.
>>
>> Thanks Joseph to review the patches.
>>
>> Rafael is expecting an Acked-by.
>>
>> If you are ok, with these patches, is it possible to ack them please ?
>>
> OK.
> 
> The 5/9 and 6/9 of this series.
> Acked-by: Joseph Lo <josephl@nvidia.com>

Thanks Joseph.




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
