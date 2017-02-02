From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  2 Feb 2017 20:30:06 +0200
Subject: [GIT PULL 2/4] soc: samsung: pmu for v4.11, third round
In-Reply-To: <20170202183008.23500-1-krzk@kernel.org>
References: <20170202183008.23500-1-krzk@kernel.org>
Message-ID: <20170202183008.23500-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Last changes around PMU driver (the header)
On top of previous pull request.

This patch (and others below) might be also pulled by Linus or Lee for:
[PATCH v3 0/7] Pad retentions support for Exynos5433
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1321519.html

Best regards,
Krzysztof


Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio at vger.kernel.org
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>


The following changes since commit ee55ae6194a5439bde3a3b8ee0abda63c610e740:

  soc: samsung: pmu: Remove duplicated define for ARM_L2_OPTION register (2017-01-27 11:32:31 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-soc-pmu-4.11-3

for you to fetch changes up to b343d77b94b6702082f4f402e1492e71ef87095b:

  soc: samsung: pmu: Add register defines for pad retention control (2017-02-02 20:00:28 +0200)

----------------------------------------------------------------
3rd round of improvements for Exynos PMU driver for v4.11:
1. Add defines in header for future patches changing the pad
   retention control.

----------------------------------------------------------------
Marek Szyprowski (1):
      soc: samsung: pmu: Add register defines for pad retention control

 include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
