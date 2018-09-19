From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 19 Sep 2018 21:54:08 +0300
Subject: [GIT PULL] arm64: dts: TI AM65x changes for 4.20
Message-ID: <404ebcc1-7e8c-c505-a6ac-10a94f6bd608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Here are the TI AM65x DTS changes towards 4.20 merge window. Applied on 
top of 4.19-rc2 basically just because of some testing considerations, 
please let me know if that is not fine.

-Tero

---

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux 
tags/am654-for-v4.20

for you to fetch changes up to 42e54f6467ecc25f464d74c0fcea0c9fab1c2e3b:

   arm64: dts: ti: k3-am6: Add Device Management Security Controller 
support (2018-09-18 18:25:06 +0300)

----------------------------------------------------------------
TI AM654 support for v4.20 merge window.

This branch adds changes for the Texas Instruments AM654 SoC. Included
changes are:
- Add uart nodes
- Change address cells and size-cells of interconnect tfrom 1 to 2
- Add secure proxy instance for main domain
- Add DMSC support

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
       arm64: dts: ti: k3-am65: Change #address-cells and #size-cells of 
interconnect to 2

Nishanth Menon (3):
       arm64: dts: ti: am654: Add uart nodes
       arm64: dts: ti: am654: Add secure proxy instance for main domain
       arm64: dts: ti: k3-am6: Add Device Management Security Controller 
support

  arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 51 
+++++++++++++++++++++---
  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        | 18 +++++++++
  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     | 46 ++++++++++++++++++++++
  arch/arm64/boot/dts/ti/k3-am65.dtsi            | 54 
+++++++++++++++-----------
  arch/arm64/boot/dts/ti/k3-am654-base-board.dts |  5 +++
  5 files changed, 147 insertions(+), 27 deletions(-)
  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
