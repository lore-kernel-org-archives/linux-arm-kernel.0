From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue,  9 Feb 2016 14:27:54 +0530
Subject: [PATCH 0/3] Syscon support for iProc touchscreen driver
Message-ID: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |  18 ++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   9 +-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 122 +++++++++++++++------
 3 files changed, 112 insertions(+), 37 deletions(-)

-- 
1.9.1
