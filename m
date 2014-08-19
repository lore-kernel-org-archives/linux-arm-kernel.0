From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 19 Aug 2014 09:17:58 +0530
Subject: [PATCH v3 12/15] cpufreq: tegra: Rename tegra-cpufreq to
 tegra20-cpufreq
In-Reply-To: <1408419205-10048-13-git-send-email-tuomas.tynkkynen@iki.fi>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
 <1408419205-10048-13-git-send-email-tuomas.tynkkynen@iki.fi>
Message-ID: <CAKohponqx8hKKXE7dc03h_tZNeEZabX6SWmHh9-RYGy7RzbRfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2014 09:03, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> The Tegra124 will use a different driver for frequency scaling, so
> rename the old driver (which handles only Tegra20) appropriately.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> v3: New patch
> ---
>  drivers/cpufreq/Kconfig.arm                            | 6 +++---
>  drivers/cpufreq/Makefile                               | 2 +-
>  drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} | 0
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
