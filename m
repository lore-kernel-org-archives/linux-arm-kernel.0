From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 Mar 2015 16:57:55 +0200
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.1
Message-ID: <CABuKBeJcRv_dGwL7qHSpSewwpmVuDvhon4JNcreYBaZ9z1E1Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following changes.

Thanks,
Matthias

---

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.0-next-soc

for you to fetch changes up to 1f022d84bd193ec88b01c6d2cb5b6647cb20a02f:

  soc: mediatek: Add PMIC wrapper for MT8135 and MT8173 SoCs
(2015-03-30 12:25:40 +0200)

----------------------------------------------------------------
- enable the pin controller in Kconfig
- Add PMIC wrapper for MT8135 and MT8173 SoCs

----------------------------------------------------------------
Flora Fu (1):
      soc: mediatek: Add PMIC wrapper for MT8135 and MT8173 SoCs

Matthias Brugger (1):
      ARM: mediatek: enable the pin controller

 arch/arm/mach-mediatek/Kconfig       |   1 +
 drivers/soc/Kconfig                  |   1 +
 drivers/soc/Makefile                 |   1 +
 drivers/soc/mediatek/Kconfig         |  11 +
 drivers/soc/mediatek/Makefile        |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c | 977 +++++++++++++++++++++++++++++++++++
 6 files changed, 992 insertions(+)
 create mode 100644 drivers/soc/mediatek/Kconfig
 create mode 100644 drivers/soc/mediatek/Makefile
 create mode 100644 drivers/soc/mediatek/mtk-pmic-wrap.c
