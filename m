From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 29 Sep 2018 17:22:34 +0200
Subject: [GIT PULL] ARM: soc driver updates for v4.20
Message-ID: <fa4576fd-e8a5-8cfb-381f-e2343bb97786@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Please have a look on the following soc driver commits.

Thanks a lot,
Matthias

---

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.19-next-soc

for you to fetch changes up to 3013b410a8f50cf251e09da00b8241fd43bb41fa:

  soc: mediatek: pwrap: add mt6357 driver for mt6765 SoCs (2018-09-25 17:36:38
+0200)

----------------------------------------------------------------
PMIC wrapper:
- sort SoCs and PMICs ascending
- add capabilities
- add support for mt8183 SoC + mt6358 PMIC
- return false instead of 0
- add support for mt6765 SoC + mt6357 PMIC

----------------------------------------------------------------
Argus Lin (3):
      dt-bindings: pwrap: mediatek: add pwrap support for MT6765
      soc: mediatek: pwrap: add pwrap driver for mt6765 SoCs
      soc: mediatek: pwrap: add mt6357 driver for mt6765 SoCs

Gustavo A. R. Silva (1):
      soc: mediatek: pwrap: use true and false for boolean values

Hsin-Hsiung Wang (3):
      dt-bindings: mediatek: add compatible for mt8183 pwrap
      soc: mediatek: pwrap: use group of bits for pwrap capability
      soc: mediatek: add mt8183 pwrap support

Matthias Brugger (1):
      soc: mediatek: pwrap: order SoCs and PMICs ascending

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   2 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 519 ++++++++++++++++-----
 2 files changed, 399 insertions(+), 122 deletions(-)
