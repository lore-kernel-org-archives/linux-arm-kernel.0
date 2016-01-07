From: louis.yu@mediatek.com (Louis Yu)
Date: Thu, 7 Jan 2016 20:09:42 +0800
Subject: [PATCH 0/2] Add Mediatek MT2701 SMP support
Message-ID: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.4-rc8 and [1], and contains smp support
for Mediatek MT2701. MT2701 contains 4 CA7 cores.

This patchset adds related SMP support for Mediatek MT2701.

[1] https://patchwork.kernel.org/patch/7248471/

Louis Yu (2):
  ARM: mediatek: add mt2701 smp bringup code
  ARM: dts: mt2701: enable basic SMP bringup for mt2701

 arch/arm/boot/dts/mt2701.dtsi    |   12 ++++++++++++
 arch/arm/mach-mediatek/platsmp.c |    1 +
 2 files changed, 13 insertions(+)

--
1.7.9.5
