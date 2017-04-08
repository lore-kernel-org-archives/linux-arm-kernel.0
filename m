From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  8 Apr 2017 16:20:50 +0200
Subject: [GIT PULL] pinctrl: samsung: Fix for v4.11
In-Reply-To: <20170408142050.1164-1-krzk@kernel.org>
References: <20170408142050.1164-1-krzk@kernel.org>
Message-ID: <20170408142050.1164-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-fixes-4.11

for you to fetch changes up to 87dc66299e51a17aacd25ad25c1f1283ca2ae305:

  pinctrl: samsung: Add missing part for PINCFG_TYPE_DRV of Exynos5433 (2017-03-23 20:47:34 +0200)

----------------------------------------------------------------
Fix for Samsung pinctrl drivers for v4.11, introduced by wrong merge conflict
resolution.

----------------------------------------------------------------
Chanwoo Choi (1):
      pinctrl: samsung: Add missing part for PINCFG_TYPE_DRV of Exynos5433

 drivers/pinctrl/samsung/pinctrl-exynos.c | 80 ++++++++++++++++----------------
 drivers/pinctrl/samsung/pinctrl-exynos.h | 11 -----
 2 files changed, 40 insertions(+), 51 deletions(-)
