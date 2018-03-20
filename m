From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 20 Mar 2018 16:36:30 +0000
Subject: [PATCH] firmware: arm_scmi: prevent accessing rate_discrete
 uninitialized
In-Reply-To: <20180316114442.9536-1-anders.roxell@linaro.org>
References: <20180316114442.9536-1-anders.roxell@linaro.org>
Message-ID: <2f747a8a-3649-b78a-e4f3-4bd8fba66e60@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anders,

On 16/03/18 11:44, Anders Roxell wrote:
> gcc-5.3 and earlier warns that rate_discrete maybe-uninitialized
>     ../drivers/firmware/arm_scmi/clock.c:185:5: warning: 'rate_discrete'
>         may be used uninitialized in this function [-Wmaybe-uninitialized]
>       if (rate_discrete)
>          ^
>     ../drivers/firmware/arm_scmi/clock.c:128:7: note:
>         'rate_discrete' was declared here
>       bool rate_discrete;
>            ^
> 
Thanks for the fix, applied.

-- 
Regards,
Sudeep
