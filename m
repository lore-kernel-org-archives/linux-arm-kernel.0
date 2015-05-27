From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 17:09:43 +0200
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.2
Message-ID: <CABuKBe+y5Em77WbKUu3YHAuwdc7n_ybLe-Eii8G1H-EQ0xZrRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please take the following changes into account.

Thanks,
Matthias

---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.1-next-soc

for you to fetch changes up to 2a910d139e405f1038c0f2ea7f9ac45acc84cce9:

  soc: mediatek: Add compile dependency to pmic-wrapper (2015-05-27
16:27:05 +0200)

----------------------------------------------------------------
- pmic wrapper: fix clock handling
- pmic wrapper: fix state machine
- pmic wrapper: fix compile dependency

----------------------------------------------------------------
Matthias Brugger (1):
      soc: mediatek: Add compile dependency to pmic-wrapper

Sascha Hauer (2):
      soc: mediatek: PMIC wrap: Fix clock rate handling
      soc: mediatek: PMIC wrap: Fix register state machine handling

 drivers/soc/mediatek/Kconfig         |  1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c | 54 ++++++------------------------------
 2 files changed, 10 insertions(+), 45 deletions(-)
