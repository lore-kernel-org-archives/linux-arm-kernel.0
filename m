From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 13 Jun 2016 17:05:14 +0200
Subject: [GIT PULL] ARM: dts: exynos: Fixes for v4.7
Message-ID: <1465830314-3942-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Two fixes for current release cycle (regressions).

Best regards,
Krzysztof


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-4.7-2

for you to fetch changes up to a7d7865fecd83adb98b20eca5eddef7efc94831d:

  ARM: dts: exynos: Fix port nodes names for Exynos5420 Peach Pit board (2016-06-07 11:00:39 +0200)

----------------------------------------------------------------
Fixes for Exynos-based Snow and Peach Pit boards for regressions introduced in
4.7-rc1 because OF graph logic expects specific names of child nodes.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: dts: exynos: Fix port nodes names for Exynos5250 Snow board
      ARM: dts: exynos: Fix port nodes names for Exynos5420 Peach Pit board

 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 13 ++++++++++---
 arch/arm/boot/dts/exynos5420-peach-pit.dts    | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)
