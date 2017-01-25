From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 25 Jan 2017 14:48:24 +0100
Subject: [GIT PULL] arm64: mediatek: dts changes for v4.11
Message-ID: <943b4e63-d2bc-0b9c-f4a7-4689f2ac48ea@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, hi Olof,

Please merge the following changes for 64-bit dts files.

Thanks,
Matthias

---

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.10-next-dts

for you to fetch changes up to 6de18454e06f4eb9c0c7008d3999cd1d0b289d42:

   arm64: dts: mt8173: add node for thermal calibration (2017-01-23 
10:18:13 +0100)

----------------------------------------------------------------
For mt8173:
- set mm_sel clock to 400 MHz to support 4K HDMI
- adjust power efficiency between the little and big cores
- add a node for thermal calibration via e-fuse data

----------------------------------------------------------------
Bibby Hsieh (1):
       arm64: dts: mt8173: add mmsel clocks for 4K support

Daniel Kurtz (1):
       arm64: dts: mt8173: Fix cpu_thermal cooling-maps contributions

dawei.chien at mediatek.com (1):
       arm64: dts: mt8173: add node for thermal calibration

  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 13 +++++++++++--
  1 file changed, 11 insertions(+), 2 deletions(-)
