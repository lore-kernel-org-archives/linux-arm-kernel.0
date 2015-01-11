From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 11 Jan 2015 22:01:51 +0100
Subject: [GIT PULL] ARM: mediatek: DT changes for v3.20 (round 1)
Message-ID: <CABuKBeK96CE-xR8Xknv1ES7u9TZybtyh84zZE9paFPPD5pZjGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please take the following patches for v3.20.

Thanks,
Matthias

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.20-next-dts

for you to fetch changes up to 3aa2e2811ab58e0299bb9a6457a15b405be86ff0:

  ARM: mediatek: dts: Add uart to Aquaris5 (2015-01-11 21:17:49 +0100)

----------------------------------------------------------------
This adds support for the mediatek sysirq and the uarts for the following SoCs:
- mt8135
- mt8127
- mt6598

For mt6592 only the sysirq support was added.

----------------------------------------------------------------
Eddie Huang (3):
      ARM: mediatek: add UART dts for mt8127 and mt8135
      DTS: serial: Add bindings document for the Mediatek UARTs
      ARM: mediatek: dts: Add UART dts for MT8127 and MT8135 boards

Howard Chen (2):
      ARM: mediatek: Add sysirq device node to mt6592 dtsi
      dt-bindings: add mt6592 compatible string for mediatek sysirq

Matthias Brugger (2):
      ARM: mediatek: dts: Add uart to mt6589
      ARM: mediatek: dts: Add uart to Aquaris5

Yingjoe Chen (1):
      ARM: mediatek: Add sysirq in mt6589/mt8135/mt8127 dtsi

 .../bindings/arm/mediatek/mediatek,sysirq.txt      |  1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |  2 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              | 12 ++++-
 arch/arm/boot/dts/mt6589.dtsi                      | 52 ++++++++++++++++++++-
 arch/arm/boot/dts/mt6592.dtsi                      | 15 ++++--
 arch/arm/boot/dts/mt8127-moose.dts                 |  4 ++
 arch/arm/boot/dts/mt8127.dtsi                      | 52 ++++++++++++++++++++-
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  4 ++
 arch/arm/boot/dts/mt8135.dtsi                      | 54 +++++++++++++++++++++-
 9 files changed, 185 insertions(+), 11 deletions(-)
