From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 2 May 2016 16:37:23 +0200
Subject: [GIT PULL] ARM: mediatek: dts updates for v4.7
Message-ID: <CABuKBe+jtD4nLXFrxTxKJ_Fq9t9D9a_ibXsSkvvZw5e5p_fZeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please take the following updates.

Thanks,
Matthias

---

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.6-next-dts

for you to fetch changes up to 610175b7972afc78f0e4a622a17a32b1fccad4bf:

  dt-bindings: MediaTek: Add binding document for the AUXADC
(2016-04-20 13:32:57 +0200)

----------------------------------------------------------------
- add pinctrl node for mt2701
- add mt2701 pmic wrapper binding
- add auxadc binding document

----------------------------------------------------------------
Biao Huang (1):
      arm: dts: Add pinctrl/GPIO/EINT node for mt2701

John Crispin (1):
      dt-bindings: ARM: Mediatek: add MT2701/7623 string to the PMIC wrapper doc

Sascha Hauer (1):
      dt-bindings: MediaTek: Add binding document for the AUXADC

 .../devicetree/bindings/soc/mediatek/auxadc.txt     | 21 +++++++++++++++++++++
 .../devicetree/bindings/soc/mediatek/pwrap.txt      |  1 +
 arch/arm/boot/dts/mt2701.dtsi                       | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
