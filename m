From: lenb@kernel.org (Len Brown)
Date: Fri, 19 Apr 2013 18:02:04 -0400
Subject: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
In-Reply-To: <1364991322-20585-7-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <1364991322-20585-7-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5171BEDC.8020205@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 08:15 AM, Daniel Lezcano wrote:
> The start/stop_critical_timings are called from arch/x86/kernel/process.c
> in the cpu_idle loop function.
> 
> Remove the ones in the cpuidle driver.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Len Brown <len.brown@intel.com>
