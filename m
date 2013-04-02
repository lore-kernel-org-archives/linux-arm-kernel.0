From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 02 Apr 2013 12:15:57 +0200
Subject: EXYNOS will support only DT from v3.10
In-Reply-To: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
References: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
Message-ID: <515AAFDD.1060204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 12:01 PM, Kukjin Kim wrote:
> Hi all,
> 
> As we discussed before, it's time to decide to support non-DT for EXYNOS
> SoCs.
> 
> If everybody else agrees to drop non-DT support from v3.10, I will. Feel
> free to talk your opinion about that.

I'm fine with supporting Exynos as dt-only from 3.10. We just need to
resolve some issues with samsung pwm/timers to get DT board support for
Universal_c210 working. Currently Tomasz Figa is working on it. Hopefully
it all can be finished this week.

I'll see if I can find some spare time and help out with porting S5PV210
to DT.


Regards,
Sylwester
