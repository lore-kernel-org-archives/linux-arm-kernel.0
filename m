From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:42 +0900
Subject: [GIT PULL 5/9] ARM: EXYNOS: Drivers for v4.5
In-Reply-To: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1449020386-20250-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Pinctrl for v4.5.

Best regards,
Krzysztof


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.5

for you to fetch changes up to 023e06dfa6882f500b9c86fd61f0b1913aa07f36:

  pinctrl: exynos: add exynos5410 SoC specific data (2015-11-16 10:54:43 +0900)

----------------------------------------------------------------
Exynos-specific drivers for 4.5:
1. Add a pinctrl driver for Exynos5410.

----------------------------------------------------------------
Hakjoo Kim (1):
      pinctrl: exynos: add exynos5410 SoC specific data

 .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 103 +++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   1 +
 4 files changed, 107 insertions(+)
