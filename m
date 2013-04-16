From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Apr 2013 10:42:17 +0200
Subject: [V3 patch 00/19] cpuidle: code consolidation
In-Reply-To: <87k3o38kh4.fsf@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <87k3o38kh4.fsf@linaro.org>
Message-ID: <516D0EE9.40704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 01:03 AM, Kevin Hilman wrote:
> Hi Daniel,
> 
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
> 
>> This patchset series provide some code consolidation across the different
>> cpuidle drivers. It contains two parts, the first one is the removal of
>> the time keeping flag and the second one, is a common initialization routine.
> 
> Do you have this series in a branch somewhere (preferrable on top of
> Rafael's linux-next) for ease of testing?

Yes, I updated my git tree [1].

Thanks for testing.

  -- Daniel

[1] git://git.linaro.org/people/dlezcano/cpuidle-next.git linux-pm-next

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
