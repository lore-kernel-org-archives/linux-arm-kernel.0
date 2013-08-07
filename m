From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Aug 2013 16:52:34 +0530
Subject: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same
 as current
In-Reply-To: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
References: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <CAKohpokp04HXau1fOA6w9K675LwRw6uCCZZKyFAJtF1_pkcC=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2013 16:46, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> This patch fixes the issue of un-necessary setting the clock controller
> when the new target frequency is same as the current one. This case usually
> occurs with governors like ondemand which passes the target frequency as the
> percentage of average frequency. This check is present in most of the cpufreq
> driver.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied.
