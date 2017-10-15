From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 Oct 2017 09:48:21 +0200
Subject: [GIT PULL 4/4] ARM: deffconfig: Pull for v4.15
In-Reply-To: <20171015074825.11338-1-krzk@kernel.org>
References: <20171015074825.11338-1-krzk@kernel.org>
Message-ID: <20171015074825.11338-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.15

for you to fetch changes up to a7620b2dff23409bb5a906e19814021e8dec00e5:

  ARM: multi_v7_defconfig: Enable UAS support for Odroid HC1 board (2017-10-04 19:20:20 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v4.15

1. Enable USB3503 on multi_v7 for Odroid U3.
2. Enable USB Attached SCSI for Odroid HC1.

----------------------------------------------------------------
Linus L?ssing (1):
      ARM: multi_v7_defconfig: Enable USB3503 driver

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable UAS support for Odroid HC1 board
      ARM: multi_v7_defconfig: Enable UAS support for Odroid HC1 board

 arch/arm/configs/exynos_defconfig   | 2 +-
 arch/arm/configs/multi_v7_defconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
