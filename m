From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 12 Sep 2016 17:51:03 +0200
Subject: [GIT PULL] ARM: mediatek: dts64 updates for v4.9
Message-ID: <786a9070-5ea7-02d2-dce6-1f069f75ca18@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please pull the following changes.

Thanks,
Matthias

----

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.8-next-dts64

for you to fetch changes up to 7475e27b45554d350f6a28edc8d0bfcf13f801c4:

   arm64: dts: mt8173-evb: enable HDMI output (2016-08-22 19:12:08 +0200)

----------------------------------------------------------------
- add HDMI related nodes to mt8173
- enable the HDMI output on mt8173-evb

----------------------------------------------------------------
CK Hu (1):
       arm64: dts: mt8173: Add HDMI related nodes

Philipp Zabel (1):
       arm64: dts: mt8173-evb: enable HDMI output

  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 38 ++++++++++++++
  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 77 
+++++++++++++++++++++++++++++
  2 files changed, 115 insertions(+)
