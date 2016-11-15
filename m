From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 17:00:31 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.10
In-Reply-To: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1479200431-1765-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.10

for you to fetch changes up to 3252e255371ad22c02d5c9d1740d408ce1b10f35:

  ARM: imx_v6_v7_defconfig: Select the es8328 codec driver (2016-10-24 19:54:38 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 4.10:
 - Increase CMA size to 64 MiB, so that we can use etnaviv driver with
   1920x1080 display devices.
 - Enable ES8328 codec driver support, which is required by Kosagi
   Novena boards.

----------------------------------------------------------------
Marek Vasut (2):
      ARM: imx_v6_v7_defconfig: Increase CMA size
      ARM: imx_v6_v7_defconfig: Select the es8328 codec driver

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)
