From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 13 Apr 2015 10:51:42 +0200
Subject: [GIT PULL] ARM: mediatek: soc fixes for v4.1
Message-ID: <CABuKBeKGjaySn=X-M-9aG22Kr1y=voA8e7ndjuXBGekmO3Rzvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following fix for v4.1.

Thanks,
Matthias

---

The following changes since commit 1f022d84bd193ec88b01c6d2cb5b6647cb20a02f:

  soc: mediatek: Add PMIC wrapper for MT8135 and MT8173 SoCs
(2015-03-30 12:25:40 +0200)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.0-next-soc-fix

for you to fetch changes up to 7a4261d5d35362d1c9ec4f80ba01ad417ca467b7:

  soc/mediatek: Remove unused variables (2015-04-13 10:35:53 +0200)

----------------------------------------------------------------
- fix unused variable warning for pmic-wrapper

----------------------------------------------------------------
Thierry Reding (1):
      soc/mediatek: Remove unused variables

 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 --
 1 file changed, 2 deletions(-)
