From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 16 Oct 2015 14:42:23 +0900
Subject: [GIT PULL] ARM: Exynos: Clock for v4.4 (dependency)
Message-ID: <1444974144-12928-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Updated to Exynos5250 clock driver, required by next pull with DT.

Best regards,
Krzysztof


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-clk-exynos5250-4.4

for you to fetch changes up to 9aaf43d9b59d6b5d8daeb3a4b9d894ea88fc34c5:

  clk: samsung: exynos5250: Add DISP1 clocks (2015-10-16 08:49:53 +0900)

----------------------------------------------------------------
Just one patch for v4.4 (required by DT pull):
New clocks for Exynos5250 to fix display issue on Snow board (HDMI
and LVDS output is broken after resume from Suspend to RAM).

----------------------------------------------------------------
Tomeu Vizoso (1):
      clk: samsung: exynos5250: Add DISP1 clocks

 drivers/clk/samsung/clk-exynos5250.c   | 14 +++++++++++++-
 include/dt-bindings/clock/exynos5250.h |  4 +++-
 2 files changed, 16 insertions(+), 2 deletions(-)
