From: nm@ti.com (Nishanth Menon)
Date: Fri, 10 Jun 2016 09:50:08 -0500
Subject: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI
 platforms
In-Reply-To: <20160610110414.GX22406@atomide.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
 <20160519044744.GE32001@vireshk-i7> <20160610110414.GX22406@atomide.com>
Message-ID: <575AD3A0.1050203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2016 06:04 AM, Tony Lindgren wrote:
> * Viresh Kumar <viresh.kumar@linaro.org> [160518 21:49]:
>> On 18-05-16, 18:36, Dave Gerlach wrote:
>>> Hi,
>>> This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
>>> and am57xx based platforms along with some support patches so that we
>>> can enable more OPPs for the CPU on these platforms.
>>>
>>> These patches rely on the ti-cpufreq series sent here [1] and provide
>>> opp-supported-hw data for each OPP so that only the appropriate OPPs
>>> for a specific piece of silicon get enabled.
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Applying all the dts changes into omap-for-v4.8/dt thanks.
> 
> Tony
> 
Viresh, are we ready with the cpufreq series?

https://patchwork.kernel.org/patch/9122961/
https://patchwork.kernel.org/patch/9122921/

Also current series: https://patchwork.kernel.org/patch/9123071/
Seems to have comments pending.

Dave is on vacation for another week or so, doubt he can respond in
time -> Should we wait on this series till we get the cpufreq support in?

-- 
Regards,
Nishanth Menon
