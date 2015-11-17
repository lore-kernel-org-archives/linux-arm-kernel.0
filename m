From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 17 Nov 2015 14:55:25 -0500
Subject: [PATCH 0/2] ARM: dts: NSP: clean-ups and I2C support
Message-ID: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Minor changes to the Broadcom Northstar Plus device tree to make it more
organized and clean, and adding I2C support (device tree only change
needed for support).


Jon Mason (2):
  ARM: dts: NSP: Device Tree clean-ups
  ARM: dts: NSP: Add I2C support to the DT

 arch/arm/boot/dts/bcm-nsp.dtsi | 59 ++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
1.9.1
