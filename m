From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Feb 2016 09:34:04 +0900
Subject: [GIT PULL 5/7] ARM: EXYNOS: Driver changes for v4.6
In-Reply-To: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455496446-23779-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Just one lonely commit.

Kind regards,
Krzysztof


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.6

for you to fetch changes up to 9b3f105ef6c75ef4f7f1bd982195db814830d78b:

  cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs (2016-01-25 15:13:53 +0900)

----------------------------------------------------------------
Exynos-specific driver changes for v4.6:
1. Minor cleanup in s5pv210-cpufreq driver.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs

 drivers/cpufreq/s5pv210-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)
