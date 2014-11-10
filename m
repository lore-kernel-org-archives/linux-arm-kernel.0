From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 10 Nov 2014 10:22:15 +0530
Subject: [PATCH v5 12/16] cpufreq: tegra: Rename tegra-cpufreq to
 tegra20-cpufreq
In-Reply-To: <1414161563-16812-13-git-send-email-mikko.perttunen@kapsi.fi>
References: <1414161563-16812-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1414161563-16812-13-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <CAKohpo=Kdh2vuvSoQBLdWfZJn3xDezpNBjqM389u45_BdizPXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 October 2014 20:09, Mikko Perttunen <mikko.perttunen@kapsi.fi> wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> The Tegra124 will use a different driver for frequency scaling, so
> rename the old driver (which handles only Tegra20) appropriately.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> ---
>  drivers/cpufreq/Kconfig.arm       |   6 +-
>  drivers/cpufreq/Makefile          |   2 +-
>  drivers/cpufreq/tegra-cpufreq.c   | 218 --------------------------------------
>  drivers/cpufreq/tegra20-cpufreq.c | 218 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 222 insertions(+), 222 deletions(-)
>  delete mode 100644 drivers/cpufreq/tegra-cpufreq.c
>  create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

Its just not readable enough.. You should have used: git format-patch -C -M
