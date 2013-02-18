From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:10 +0530
Subject: [PATCH v6 00/16] clk: exynos4/5: migrate to common clock framework 
Message-ID: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v5:
- Squashed several Exynos4 fixes patch from Tomasz Figa
- Included support for Exynos5250 and Exynos5440, thus converting all
  Exynos4 and Exynos5 platforms to common clock framework.
- Depends on the following patch series.
  - http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15849.html
  - http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15852.html

Changes since v4:
- Rebased to linux-3.8-rc1.

Changes since v3:
- Includes changes suggested by Tomasz Figa <tomasz.figa@gmail.com>

This patch series migrates the Samsung Exynos4/5 SoC clock code to adopt the
common clock framework. The use of Samsung specific clock structures has
been removed and all board support code has been updated. imx-style of
clock registration and lookup has been adopted for device tree based
exynos4/5 platforms.
