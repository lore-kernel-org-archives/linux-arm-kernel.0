From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Tue, 15 Jul 2014 16:01:32 +0530
Subject: [PATCH v3 0/2] Add mask-tpm-reset DT node to the exynos5
Message-ID: <1405420294-9323-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds mask-tpm-reset DT node to the exynos5420 and exynos5800.

rebase on for-next branch of kgene tree
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/

Tested on exynos5420 and exynos5800 based Chromebooks (both pit and pi).

changes since v2:
	- reordered the dt node based on gpio number
	- included the exynos5800-peach-pi patch in this series

changes since v1:
	- removed fixed regulator and used hogs instead.

Doug Anderson (1):
  ARM: dts: Add mask-tpm-reset to the device tree

Vikas Sajjan (1):
  ARM: dts: Add mask-tpm-reset DT node to the exynos5800-peach-pi

 arch/arm/boot/dts/exynos5420-peach-pit.dts |   12 ++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |   12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
1.7.9.5
