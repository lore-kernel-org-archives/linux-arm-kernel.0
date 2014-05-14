From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 14 May 2014 20:03:11 +0200
Subject: [GIT PULL 4/4] Samsung clock support for Exynos3250 for v3.16
In-Reply-To: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
References: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
Message-ID: <1400090591-5064-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3bc0c5a16d65ef2a2edb7326f5b77d6a5bcf08a5:

  drivers: clk: use COMMON_CLK_SAMSUNG for Samsung clock support (2014-05-14 19:41:15 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git for_3.16/exynos3250

for you to fetch changes up to 2ce16c53422a17c0afea8203dd96ac1e7a142cf9:

  clk: samsung: exynos3250: Add clocks using common clock framework (2014-05-14 19:41:32 +0200)

----------------------------------------------------------------

Samsung clock support for Exynos3250 for v3.16.

This small pull request contains a patch adding clock driver for Exynos3250,
which depends on previous pull requests in this series.

----------------------------------------------------------------
Tomasz Figa (1):
      clk: samsung: exynos3250: Add clocks using common clock framework

 drivers/clk/samsung/Makefile           |   1 +
 drivers/clk/samsung/clk-exynos3250.c   | 780 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos3250.h | 258 +++++++++++
 3 files changed, 1039 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-exynos3250.c
 create mode 100644 include/dt-bindings/clock/exynos3250.h
