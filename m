From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 25 Nov 2016 17:03:12 +0100
Subject: [PATCH 0/3] ARM: dts: da850: tilcdc related DT changes
Message-ID: <1480089795-29811-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I previously sent these patches separately, but since they're touching
the same files while coming from different trees, I decided to post
it again in a series to make applying them easier.

Bartosz Golaszewski (3):
  ARM: da850-lcdk: add the dumb-vga-dac node
  ARM: dts: da850: specify the maximum bandwidth for tilcdc
  ARM: dts: da850: enable the memctrl and mstpri nodes per board

 arch/arm/boot/dts/da850-lcdk.dts | 66 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 20 ++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.9.3
