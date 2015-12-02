From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:43 +0900
Subject: [GIT PULL 6/9] ARM: EXYNOS: clk: Another clock dependency, ARMv7,
 for v4.5
In-Reply-To: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1449020386-20250-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

This is also clock dependency. I put it in separate tag in case clock
folks want to pull it also.

Best regards,
Krzysztof


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-exynos4-4.5

for you to fetch changes up to 94af7a3c310f5877dc6f756179b92f24f89a9b08:

  clk: samsung: exynos4: Add SSS gate clock (2015-11-18 22:02:02 +0900)

----------------------------------------------------------------
Add a Security SubSystem (SSS) clock for Exynos4, needed by exynos-rng
driver (Pseudo Random Number Generator).

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      clk: samsung: exynos4: Add SSS gate clock

 drivers/clk/samsung/clk-exynos4.c   | 1 +
 include/dt-bindings/clock/exynos4.h | 1 +
 2 files changed, 2 insertions(+)
