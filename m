From: thomas.ab@samsung.com (Thomas Abraham)
Date: Mon, 20 Oct 2014 17:11:15 +0530
Subject: [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Message-ID: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v10:
- Rebased on top of v3.18-rc1

This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
drivers and enables the use of cpufreq-dt driver for these platforms. This
series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
driver.

This patch series is based and tested on v3.18-rc1 and depends on the patch
- "clk: exynos4: remove duplicate div_core2 divider clock instantiation"
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34859.html)
  This patch has been merged in "arm-soc/samsung/dt3" branch of arm-soc tree.
