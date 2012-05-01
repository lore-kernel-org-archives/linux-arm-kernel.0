From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 01 May 2012 10:16:01 +0200
Subject: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <87vckgltdg.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com>
Message-ID: <4F9F9BC1.9020908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2012 12:58 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>> This patchset makes some cleanup on these cpuidle drivers
>>> and consolidate the code across both architecture.
>>>
>>> Tested on OMAP3 (igepV2).
>>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.
>
> Without offlining CPU1, none of this code is executed.  Can you test
> with CPU1 offlined?

Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
Rob tested the series but when he unplugged the cpu1, the kernel panics 
for another reason. I guess the problem should have been fixed since the 
last testing.

Rob ? Do you mind the test the series again, the problem you were facing 
when unplugging the cpu1 may have been fixed.

Mike ? if you have time, is it possible you test it on your board ?

>> Hi,>>
>> could be this patchset considered for inclusion ?
>>
>
> Yes.   This is a good series, and a great cleanup.
>
> Unfortunately, there is lots of OMAP PM code to review at the moment so
> there's a bit of a lag in my ability to review and test.

Ok, sure. I understand, no pressure :)

Thanks a lot.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
