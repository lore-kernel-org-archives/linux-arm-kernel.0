From: dawei.chien@mediatek.com (Dawei Chien)
Date: Fri, 4 Sep 2015 17:01:47 +0800
Subject: thermal: mediatek: Add cpu power cooling model
Message-ID: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use Intelligent Power Allocation (IPA) technical to add
static/dynamic power model for binding CPU thermal zone.
The power allocator governor allocates power budget to control
CPU temperature.

Dawei.Chien (2):
  thermal: mediatek: Add cpu power cooling model.
  arm64: dts: mt8173: Add thermal zone node for mt8173.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c         |   97 ++++++++++++++++++++++++++----
 2 files changed, 130 insertions(+), 11 deletions(-)

--
1.7.9.5
