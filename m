From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Apr 2013 13:18:55 +0200
Subject: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
In-Reply-To: <5155BB27.4000405@wwwdotorg.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
 <5155BB27.4000405@wwwdotorg.org>
Message-ID: <515C101F.1020801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 05:02 PM, Stephen Warren wrote:
> On 03/29/2013 04:31 AM, Daniel Lezcano wrote:
>> Initialize the idle states directly in the driver structure.
>>
>> That prevents extra structure declaration and memcpy at init time.
> 
> Joseph, can you please review/ack patch 5/9 and patch 6/9. Thanks.

Thanks Joseph to review the patches.

Rafael is expecting an Acked-by.

If you are ok, with these patches, is it possible to ack them please ?

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
