From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 10 Jul 2018 14:25:29 -0700
Subject: [PATCH 0/2] Stingray Smart NIC DT support
Message-ID: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds DT support for Stingray smart NIC boards

This patch series is based off v4.18-rc3 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-smartnic-dt-v1

Ray Jui (1):
  arm64: dts: stingray: add PAXC support

Vladimir Olovyannikov (1):
  arm64: dts: stingray: add bcm958802a802x dts

 arch/arm64/boot/dts/broadcom/stingray/Makefile     |  2 +
 .../boot/dts/broadcom/stingray/bcm958802a802x.dts  | 26 +++++++++++
 .../boot/dts/broadcom/stingray/stingray-pcie.dtsi  | 54 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 11 +++++
 4 files changed, 93 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi

-- 
2.1.4
