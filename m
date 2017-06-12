From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 12 Jun 2017 12:37:42 +0200
Subject: [GIT PULL] ARM: Mediatek soc drivers for v4.13
Message-ID: <25946bae-31fb-ab97-aedb-92681cf603c4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, hi Anrd,

Please merge this updates for mediatek soc drivers.

Regards,
Matthias

---

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.12-next-soc

for you to fetch changes up to 58a823dd7b515827ed07adb268e1769b3c292586:

   soc: mediatek: PMIC wrap: Fix possible NULL derefrence. (2017-05-15 
10:47:25 +0200)

----------------------------------------------------------------
- enhance scpsys to support mt6797
- add mt6797 support to scpsys
- fix error path in pmic-wrapper
- fix possible NULL pointer dereference in pmic-wrapper

----------------------------------------------------------------
Christophe Jaillet (1):
       soc: mediatek: PMIC wrap: Fix error handling

Mars Cheng (3):
       soc: mediatek: avoid using fixed spm power status defines
       soc: mediatek: add vdec item for scpsys
       soc: mediatek: add MT6797 scpsys support

shailendra.v at samsung.com (1):
       soc: mediatek: PMIC wrap: Fix possible NULL derefrence.

  drivers/soc/mediatek/mtk-pmic-wrap.c     |  14 ++-
  drivers/soc/mediatek/mtk-scpsys.c        | 149 
+++++++++++++++++++++++++++++--
  include/dt-bindings/power/mt6797-power.h |  30 +++++++
  3 files changed, 184 insertions(+), 9 deletions(-)
  create mode 100644 include/dt-bindings/power/mt6797-power.h
