From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 27 Sep 2018 08:24:48 +0000
Subject: [GIT PULL] berlin dt64 changes for v4.20
Message-ID: <20180927162106.7a7e48f7@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the pull request for berlin dt64 changes for v4.20.

Thanks,
Jisheng

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin64-dt-for-v4.20

for you to fetch changes up to 087682f5a75bec349cdcb34c29384a051587aa99:

  arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC (2018-09-27 14:48:43 +0800)

----------------------------------------------------------------
Berlin64 DT changes for v4.20

 - move berlin binding documentation to syna.txt
 - add binding for the AS370 SoC
 - add dtsi file for Synaptics AS370 SoC

----------------------------------------------------------------
Jisheng Zhang (3):
      dt-bindings: arm: move berlin binding documentation to syna.txt
      dt-bindings: arm: syna: add support for the AS370 SoC
      arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC

 .../arm/{marvell/marvell,berlin.txt => syna.txt}   |  11 +-
 arch/arm64/boot/dts/synaptics/as370.dtsi           | 173 +++++++++++++++++++++
 2 files changed, 183 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (89%)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
