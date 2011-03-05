From: shweta.gulati@ti.com (Shweta Gulati)
Date: Sat,  5 Mar 2011 15:20:21 +0530
Subject: [PATCH V2 0/3]: OMAP4: Update OPP Table and Voltage Rail Values
Message-ID: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Series Updates OPP Table for MPU, add OPP enteries
for IVA and update Voltage Rail values for MPU/IVA.

It is based on the Patch which replaces
Voltage values with Macros, Submitted by 
Nishanth Menon 
https://patchwork.kernel.org/patch/607541/

Branch: pm-core

Tested on OMAP4430 SDP.

V2:
Rebased on pm-core and incorporated
comments from Nishanth Menon. 

Shweta Gulati (3):
  OMAP4: Enable 800 MHz and 1 GHz OPP for OMAP4.
  OMAP4: Update Voltage Rail Values for MPU/IVA
  OMAP4: Add IVA OPP enteries.

 arch/arm/mach-omap2/opp4xxx_data.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)
