From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 Nov 2016 19:39:10 +0100
Subject: [GIT PULL] arm: mediatek: soc changes for v4.10
Message-ID: <002ed210-0f74-e938-b69f-c91ae98d37e4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Although a bit late, please take the following changes into account.

Thanks a lot,
Matthias
---
The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.9-next-soc

for you to fetch changes up to 112ef1882e12094c823937f9d72f2f598db02df7:

   soc: mediatek: Add MT2701 scpsys driver (2016-10-31 00:58:58 +0100)

----------------------------------------------------------------
- prepare mtk-scpsys to for multi soc support
- add support for mt2701 to mtk-scpsys

----------------------------------------------------------------
James Liao (1):
       soc: mediatek: Refine scpsys to support multiple platform

Shunli Wang (1):
       soc: mediatek: Add MT2701 scpsys driver

  drivers/soc/mediatek/Kconfig      |   2 +-
  drivers/soc/mediatek/mtk-scpsys.c | 465 
++++++++++++++++++++++++++------------
  2 files changed, 327 insertions(+), 140 deletions(-)
