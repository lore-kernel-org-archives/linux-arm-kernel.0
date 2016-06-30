From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Jun 2016 09:51:13 +0200
Subject: [GIT PULL 2/4] ARM: exynos: Drivers for v4.8, part 2
In-Reply-To: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
References: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1467273075-13747-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull.

Best regards,
Krzysztof


The following changes since commit 9479f7cc91879c6ba75e70da41c4c9fe7842b342:

  soc: samsung: pm_domains: Enable COMPILE_TEST for build coverage (2016-05-30 09:12:57 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.8-2

for you to fetch changes up to 187364b6fcabb9f4bfefcb62fab4fcda019b5810:

  cpufreq: s5pv210: use relaxed IO accesors (2016-06-22 14:00:21 +0200)

----------------------------------------------------------------
Samsung drivers/soc update for v4.8, part 2:
1. Endian-friendly fixes.
2. Make SROMC driver explicitly non-module.

----------------------------------------------------------------
Ben Dooks (2):
      memory: samsung: endian fixes for IO
      cpufreq: s5pv210: use relaxed IO accesors

Paul Gortmaker (1):
      memory: samsung: exynos-srom: make it explicitly non-modular

 drivers/cpufreq/s5pv210-cpufreq.c    | 68 ++++++++++++++++++------------------
 drivers/memory/samsung/exynos-srom.c | 39 +++++++--------------
 2 files changed, 46 insertions(+), 61 deletions(-)
