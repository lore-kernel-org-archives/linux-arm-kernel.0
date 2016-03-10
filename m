From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 10 Mar 2016 18:16:47 +0800
Subject: [GIT PULL]Hisilicon Hi6220 SoC and Hikey board DT updates for 4.6
Message-ID: <56E1498F.2030107@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hi6220-dt-for-4.6

for you to fetch changes up to 1dd86c2b042f24e194ff9fff4d0f58d5824edda7:

  arm64: dts: add wifi nodes support for hi6220-hikey (2016-02-25 19:47:44 +0800)

----------------------------------------------------------------
ARM64: DT: Hisilicon Hi6220 soc and hikey board updates for 4.6

- Reserve memory regions for Hi6220
- Add sp804 timer node for Hi6220
- Add cpu and cluster level's low power state for Hi6220
- Add gpio configuration nodes for Hi6220
- Add pinctrl configuration nodes for Hi6220
- Add spi related nodes for Hi6220
- Add i2c nodes for Hi6220
- Enable i2c nodes to work with mezzanine boards
- Add usb nodes for Hi6220
- Add mailobx node for Hi6220
- Enable SRAM node and stub clock node for Hi6220
- Add pinctrl nodes for uarts and enable them
- Add LED nodes for hi6220-hikey board
- Add hi655x pmic node for Hi6220
- Add dwmmc nodes for Hi6220
- Add resets property into dwmmc nodes
- Add wifi nodes support for Hi6220-Hikey board

----------------------------------------------------------------
Chen Feng (1):
      arm64: dts: hikey: Add hi655x pmic dts node

Guodong Xu (5):
      arm64: dts: hikey: enable i2c0 and i2c1 for working with mezzanine boards
      arm64: dts: hi6220: add pinctrl for uarts and enable them
      arm64: dts: add LED nodes for hi6220-hikey
      arm64: dts: hi6220: add resets property into dwmmc nodes
      arm64: dts: add wifi nodes support for hi6220-hikey

Leo Yan (5):
      arm64: dts: Reserve memory regions for hi6220
      arm64: dts: add sp804 timer node for Hi6220
      arm64: dts: enable idle states for Hi6220
      arm64: dts: add mailbox node for Hi6220
      arm64: dts: add Hi6220's stub clock node

Xinwei Kong (2):
      arm64: dts: add all hi6220 i2c nodes
      arm64: dts: add dwmmc nodes for hi6220

Zhangfei Gao (1):
      arm64: dts: add hi6220 usb node

Zhong Kaihua (3):
      arm64: dts: Add Hi6220 gpio configuration nodes
      arm64: dts: add Hi6220 pinctrl configuration nodes
      arm64: dts: add Hi6220 spi configuration nodes

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   | 196 ++++++-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 586 +++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi    | 607 +++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 705 +++++++++++++++++++++++
 include/dt-bindings/pinctrl/hisi.h               |  59 ++
 5 files changed, 2149 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
 create mode 100644 include/dt-bindings/pinctrl/hisi.h
