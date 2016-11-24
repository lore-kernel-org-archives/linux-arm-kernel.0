From: marcel@ziswiler.com (marcel at ziswiler.com)
Date: Thu, 24 Nov 2016 02:04:50 +0100
Subject: [RESEND PATCH 0/6] apalis-tk1: updates for v1.1 hw
Message-ID: <20161124010456.24604-1-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series updates the device tree for the upcoming V1.1 HW samples.
All changes are purely opportunistic meaning they fix stuff which on
older HW was anyway broken so there should be no backwards
compatibility issues.


Marcel Ziswiler (6):
  apalis-tk1: remove spurious new lines
  apalis-tk1: temp alert pull-up
  apalis-tk1: optional displayport hot-plug detect
  apalis-tk1: adjust pin muxing for v1.1 hw
  apalis-tk1: working sd card detect on v1.1 hw
  apalis-tk1: update compatibility comment

 arch/arm/boot/dts/tegra124-apalis-eval.dts | 11 +----
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 73 +++++++++++-------------------
 2 files changed, 29 insertions(+), 55 deletions(-)

-- 
2.9.3
