From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 29 Sep 2018 17:16:15 +0200
Subject: [GIT PULL] ARM: defconfig update for v4.20
Message-ID: <8bb0af1d-8323-9833-ee1c-bbbb9d65a686@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Please have a look on the following pull request.

Thanks,
Matthias

---
The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.19-next-defconfig

for you to fetch changes up to f718739d1c219decf2e4e4f0121753439850e5ab:

  ARM: defconfig: add mediatek_v7_defconfig (2018-09-25 16:18:15 +0200)

----------------------------------------------------------------
- add arm32 defconfig for mediatek SoCs.

----------------------------------------------------------------
Sean Wang (1):
      ARM: defconfig: add mediatek_v7_defconfig

 arch/arm/configs/mediatek_v7_defconfig | 319 +++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)
 create mode 100644 arch/arm/configs/mediatek_v7_defconfig
