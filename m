From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 2 Sep 2015 11:03:33 -0700
Subject: [PATCH v2] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441212476-21316-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441212476-21316-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <55E739F5.8060000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2015 09:47 AM, Bartlomiej Zolnierkiewicz wrote:
> Add suspend frequency support and set it to the boot frequency,
> this matches what the old exynos-cpufreq driver has been doing.
>
> This patch fixes suspend/resume support on Exynos4412 based
> Trats2 board and reboot hang on Exynos4412 based Odroid U3
> board.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This patch supersedes "[PATCH] ARM: dts: exynos4412-odroid-*: add
> workaround for CPUfreq/reboot issue" one from yesterday.

What do we do about cpufreq-dt users that don't want to change frequency
during suspend?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
