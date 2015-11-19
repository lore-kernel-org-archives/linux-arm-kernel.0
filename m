From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 19 Nov 2015 12:31:00 +0530
Subject: [PATCH 0/2] adding spi alias for qspi
Message-ID: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding missed spi alias for qspi which helps probe the qspi
device in U-Boot.

Mugunthan V N (2):
  dts: dra7: add spi alias for qspi
  arm: dts: am4372: add spi alias for qspi

 arch/arm/boot/dts/am4372.dtsi | 1 +
 arch/arm/boot/dts/dra7.dtsi   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.6.2.280.g74301d6
