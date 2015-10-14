From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 14 Oct 2015 18:14:48 -0400
Subject: [PATCH v2 0/2] ARM: dts: bcm5301x: Add BCM SVK DT files
Message-ID: <1444860890-28649-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds the device tree files for the Broadcom Northstar based SVKs.  

Changes in v2:
* Reorder the patches to add the DT binding documentation prior to the new DT files
* Removed the DT documentation compat strings to only the SoCs, not the individual boards
* Fixed the compat strings in the individual device tree files
* Added the memory node and removed the "mem=" from the bootargs

Thanks,
Jon
