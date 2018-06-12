From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 12 Jun 2018 13:21:26 -0700
Subject: [PATCH 0/5] Fix Cygnus, NS2, Stingray interrupt type
Message-ID: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes incorrect interrupt types for I2C and PCIe in DT
for Broadcom Cygnus, NS2, and Stingray SoCs

This patch series is based off v4.17 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: cygnus-ns2-dt-irq-type-fix-v1

Ray Jui (5):
  ARM: dts: cygnus: Fix I2C controller interrupt type
  ARM: dts: cygnus: Fix PCIe controller interrupt type
  ARM64: dts: ns2: Fix I2C controller interrupt type
  ARM64: dts: ns2: Fix PCIe controller interrupt type
  ARM64: dts: Stingray: Fix I2C controller interrupt type

 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 24 +++++++++++-----------
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  8 ++++----
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.1.4
