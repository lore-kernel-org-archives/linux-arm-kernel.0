From: nm@ti.com (Nishanth Menon)
Date: Mon, 8 Sep 2014 11:29:04 -0500
Subject: [PATCH 00/10] ARM: OMAP5 / DRA7: Add framework for suspend and
 cpuidle
In-Reply-To: <7htx4xbv7p.fsf@paris.lan>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
 <7htx4xbv7p.fsf@paris.lan>
Message-ID: <540DD950.30207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 02:15 PM, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
>> The following series are various fixes and improvements for
>> supporting suspend-to-ram. This depends on the following for basic functionality:
>> series 1/6 where powerdomain fixes were involved.
> 
> I had a look through this series, and it looks good overall.  I think Daniel
> needs to weigh in on the CPUidle driver, otherwise.
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> I also tested on omap5uevm with the pm_debug/wakeup_timer_seconds patch.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Kevin
> 

I am dropping cpuidle patch for the moment, and sending remaining
stuff to Tony for merge with Kevin's Reviewed and Tested. we will send
cpuidle once we have Daniel's response.

-- 
Regards,
Nishanth Menon
