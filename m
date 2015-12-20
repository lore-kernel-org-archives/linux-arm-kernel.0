From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 20 Dec 2015 22:22:41 +0100
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.4
Message-ID: <CABuKBeK7v2B_X4i-s02uiK-NpmxeGB2qtXokupsfVCJ5TOte9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following patches.

Thanks,
Matthias

---

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.4-next-soc

for you to fetch changes up to e50be5cd0caa1d3c59d2fa9064c3932f3f74e047:

  drivers/soc: make mediatek/mtk-scpsys.c explicitly non-modular
(2015-12-18 09:41:43 +0100)

----------------------------------------------------------------
Change the scpsys to builtin_platform_driver_probe.

Add regulator support for scpsys driver.

----------------------------------------------------------------
Paul Gortmaker (1):
      drivers/soc: make mediatek/mtk-scpsys.c explicitly non-modular

Sascha Hauer (1):
      soc: mediatek: SCPSYS: Add regulator support

 drivers/soc/mediatek/mtk-scpsys.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)
