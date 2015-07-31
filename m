From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 31 Jul 2015 20:55:13 +0200
Subject: [PATCH V3 00/16] OPP: Add code to support operating-points-v2
 bindings
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <26644874.9clcJiszPI@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, July 29, 2015 04:22:55 PM Viresh Kumar wrote:
> Hi Guys,
> 
> Resending this again because:
> - opp-hz is now 64 bit long and so that required a binding update.
> - There is another 4 patch series that as updating turbo OPP support,
>   along with updates to cpufreq core and cpufreq-dt driver.
> - A minor bug-fix in V2 4/11, which caused false positive for duplicate
>   OPPs in some cases.
> 
> Tested this on dual-core exynos board with the driver inbuilt as well as
> a module. Tried multiple insertion/removals of the module. Have tested
> cpufreq-dt driver with both old and new bindings.

I have tested these patches (including boost support) together with my
cpufreq-dt conversion patches for Exynos4x12 platforms on Odroid-U3 and
Trats2 boards.

Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
