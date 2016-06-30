From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:38 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.8
Message-ID: <cover.1467292079.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.8.


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.8

for you to fetch changes up to a1becf12c6dafd96d77e97c9a7cbc446ba1d1196:

  ARM: multi_v7_defconfig: defconfig: Enable r8a7792 SoC (2016-06-20 17:53:03 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.8

* Enable newly added support for r8a7792 SoC in multi_v7 and shmobile
  defconfigs

----------------------------------------------------------------
Simon Horman (2):
      ARM: shmobile: defconfig: Enable r8a7792 SoC
      ARM: multi_v7_defconfig: defconfig: Enable r8a7792 SoC

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 1 +
 2 files changed, 2 insertions(+)
