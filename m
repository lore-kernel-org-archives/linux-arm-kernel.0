From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 Nov 2016 19:36:36 +0100
Subject: [GIT PULL] arm: mediatek: dts changes for v4.10
Message-ID: <c148f205-79fc-3578-84db-cce4063e42ec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

although late, please pull the following changes.

Thanks,
Matthias
---
The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.9-next-dts

for you to fetch changes up to 28d6e3647bd7c869bfc251f9a7e283d78cef5fc5:

   arm: dts: mt2701: Use real clock for UARTs (2016-11-11 15:25:09 +0100)

----------------------------------------------------------------
- Add bindings for mtk-scpsys for mt2701
- Add clocks for auxadc on mt8173-evb
- Add nodes needed by clock controller for mt2701
- Use clocks from the clock controller for the uart of mt2701

----------------------------------------------------------------
Erin Lo (1):
       arm: dts: mt2701: Use real clock for UARTs

James Liao (1):
       arm: dts: mt2701: Add clock controller device nodes

Matthias Brugger (1):
       arm64: dts: mt8173: Fix auxadc node

Shunli Wang (1):
       soc: mediatek: Add MT2701 power dt-bindings

  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 13 +++---
  arch/arm/boot/dts/mt2701.dtsi                      | 50 
+++++++++++++++++++---
  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  3 ++
  include/dt-bindings/power/mt2701-power.h           | 27 ++++++++++++
  4 files changed, 83 insertions(+), 10 deletions(-)
  create mode 100644 include/dt-bindings/power/mt2701-power.h
