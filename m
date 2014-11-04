From: stefan@agner.ch (Stefan Agner)
Date: Tue,  4 Nov 2014 14:07:07 +0100
Subject: [PATCH 0/3] ARM: dts: vf610: USB/GPIO fixes
Message-ID: <1415106430-6271-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

This patchset collects some vf610 device tree fixes. The first patch
was part of the "vf610: Add GPIO support" patchset. GPIO support is
merged by know, so I rebased that on top of your for-next branch.

The second patch is a USB fix I uncovered while testing the 3rd patch,
which adds regulators, mainly for proper USB VBUS support, as we have
them on our carrier boards.

Stefan Agner (3):
  ARM: dts: vf610: use new GPIO support
  ARM: dts: vf610: enable USB misc/phy nodes where necessary
  ARM: dts: vf-colibri: add USB regulators

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 45 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/vf-colibri.dtsi         | 37 +++++++++++++++++++++++++
 arch/arm/boot/dts/vf610-twr.dts           |  9 +++++++
 arch/arm/boot/dts/vfxxx.dtsi              |  1 +
 4 files changed, 91 insertions(+), 1 deletion(-)

-- 
2.1.3
