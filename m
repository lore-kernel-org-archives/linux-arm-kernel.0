From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 30 Mar 2016 10:27:41 -0500
Subject: [PATCH] Addition of Altera Arria10 On-Chip RAM ECC
Message-ID: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches adds the Arria10 OCRAM EDAC support.

[PATCH 1/7] EDAC, altera: New file operations for Arria10 ECC
[PATCH 2/7] EDAC, altera: Add register offset for ECC Enable
[PATCH 3/7] EDAC, altera: Make OCRAM ECC dependency check generic
[PATCH 4/7] Documentation: dt: socfpga: Add Altera Arria10 OCRAM
[PATCH 5/7] EDAC, altera: Addition of Arria10 OCRAM ECC
[PATCH 6/7] ARM: socfpga: Enable Arria10 OCRAM ECC on startup
[PATCH 7/7] ARM: dts: Add Altera Arria10 OCRAM EDAC devicetree entry
