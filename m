From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 20 Dec 2017 20:18:10 +0100
Subject: [GIT PULL] arm: Updates of armv7 DTS for v4.15-next
Message-ID: <8bf16d56-579c-1579-142f-121990ec0572@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please feel free to pull the following patches.

Thanks,
Matthias

---
The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
tags/v4.15-next-dts64

for you to fetch changes up to c0c3333daba6617b44228a8dffb8184b2fd1931d:

  arm64: dts: Add power controller device node of MT2712 (2017-12-20 20:02:50 +0100)

----------------------------------------------------------------
- mt8173 add cpufreq related nodes
  supply nodes
  frequency/voltage operation table

- mt2712 add cpufreq related nodes
  fixed regulator
  supply nodes
  frequency/voltage operation table
- mt2712 add clock contoller nodes
- mt2712 add scpsys node

----------------------------------------------------------------
Andrew-sh Cheng (2):
      arm64: dts: mediatek: add mt8173 cpufreq related device nodes
      arm64: dts: mediatek: add mt2712 cpufreq related device nodes

weiyi.lu at mediatek.com (2):
      arm64: dts: mt2712: Add clock controller device nodes
      arm64: dts: Add power controller device node of MT2712

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  27 ++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 188 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  18 +++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  90 +++++++++++++
 4 files changed, 323 insertions(+)
