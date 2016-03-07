From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:42:56 -0600
Subject: [PATCHv2 0/11] Series adding Altera Arria10 L2 Cache EDAC 
Message-ID: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This version splits the larger patch in V1 into smaller,
patches.

 [PATCHv2 01/11] EDAC: Altera L2 Kconfig change from select to
 [PATCHv2 02/11] EDAC, altera: Move Device structs and defines to
 [PATCHv2 03/11] EDAC, altera: Add register offset for ECC Enable
 [PATCHv2 04/11] EDAC, altera: Add register offset for ECC Error
 [PATCHv2 05/11] EDAC, altera: Add register offset for ECC Error
 [PATCHv2 06/11] EDAC, altera: Add IRQ flags to private data struct
 [PATCHv2 07/11] EDAC, altera: Add status offset & masks
 [PATCHv2 08/11] Documentation: dt: socfpga: Add Altera Arria10 L2
 [PATCHv2 09/11] EDAC, altera: Addition of Arria10 L2 Cache ECC
 [PATCHv2 10/11] ARM: socfpga: Enable Arria10 L2 cache ECC on startup
 [PATCHv2 11/11] ARM: dts: Add Altera Arria10 L2 Cache EDAC
