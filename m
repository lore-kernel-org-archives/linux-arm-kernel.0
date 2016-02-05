From: jonmason@broadcom.com (Jon Mason)
Date: Fri,  5 Feb 2016 17:43:19 -0500
Subject: [PATCH 0/5] ARM: dts: NSP: DT Updates 
Message-ID: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Northstar Plus device tree changes.  The first 2 are bug fixes that
probably should go in ASAP.  The other 3 enable new hardware and can be
pushed into the next merge window.

Thanks,
Jon

Jon Mason (5):
  ARM: dts: NSP: Fix PCIE DT issue
  ARM: dts: NSP: Fix CPU DT issue
  ARM: dts: NSP: Add PMU Support to DT
  ARM: dts: NSP: Add SP805 Support to DT
  ARM: dts: NSP: Add SP804 Support to DT

 arch/arm/boot/dts/bcm-nsp.dtsi | 193 +++++++++++++++++++++++------------------
 1 file changed, 107 insertions(+), 86 deletions(-)

-- 
1.9.1
