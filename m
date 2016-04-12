From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:12:55 -0500
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
Message-ID: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the memory initialization functions for Altera's
Arria10 peripherals, the first of which is the Ethernet EDAC. The
first 3 patches add the memory initialization functionality. The
last 3 patches add Ethernet EDAC support.

[PATCH 1/6] EDAC, altera: Check parent status for Arria10 EDAC block
[PATCH 2/6] EDAC, altera: Move IRQ function declaration
[PATCH 3/6] EDAC, altera: Add Arria10 ECC memory init functions
[PATCH 4/6] Documentation: dt: socfpga: Add Arria10 Ethernet binding
[PATCH 5/6] EDAC, altera: Add Arria10 Ethernet EDAC support
[PATCH 6/6] ARM: dts: Add Arria10 Ethernet EDAC devicetree entry
