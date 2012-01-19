From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Jan 2012 10:18:05 +0100
Subject: [PATCH 4/4] at91 : implement the standby function for pm/cpuidle
In-Reply-To: <20120118224544.GT1068@n2100.arm.linux.org.uk>
References: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
 <1326843620-13148-5-git-send-email-daniel.lezcano@linaro.org>
 <4F1742E8.8090108@gmail.com> <20120118221845.GS1068@n2100.arm.linux.org.uk>
 <4F1746DE.4000902@gmail.com> <20120118224544.GT1068@n2100.arm.linux.org.uk>
Message-ID: <4F17DFCD.7040905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2012 11:45 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 19, 2012 at 09:25:34AM +1100, Ryan Mallon wrote:
>> After this patch we still have the limitation that only one at91
>> platform can be built into the kernel (this is an existing problem,
>> which there is an on going effort to resolve) because the at91_standby
>> function is defined via ifdefs. So the at91_standby define should still
>> be converted to a function pointer and assigned via the soc right? Of
>> course, this can be done in a subsequent patch.

Yes, this is what I planned to do but I wanted to bring this fix and do 
some code cleanup before switching this to an ops.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
