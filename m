From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:13:41 +0200
Subject: arm: soc fixes for v4.6
Message-ID: <570E1BD5.4090305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please merge the following fix to end the boot regression for v4.6.

Thanks,
Matthias

---

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.6-soc-fixes

for you to fetch changes up to d9c9f3b809d2bb0356f013e88d10730eafab5346:

   Revert "soc: mediatek: SCPSYS: Fix double enabling of regulators" 
(2016-04-13 11:55:08 +0200)

----------------------------------------------------------------
- fix boot error reverting commit cc8ed76938b5
("soc: mediatek: SCPSYS: Fix double enabling of regulators")

----------------------------------------------------------------
James Liao (1):
       Revert "soc: mediatek: SCPSYS: Fix double enabling of regulators"

  drivers/soc/mediatek/mtk-scpsys.c | 11 ++++++-----
  1 file changed, 6 insertions(+), 5 deletions(-)
