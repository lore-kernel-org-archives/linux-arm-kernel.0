From: p.paneri@samsung.com (p.paneri at samsung.com)
Date: Tue, 21 Jun 2011 12:33:42 +0530
Subject: [RFC][PATCH 0/5] USB: DWC OTG: Add dwc_otg driver for S5P6440 samsung
	SoC.
Message-ID: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Praveen Paneri <p.paneri@samsung.com>

These patches modify DWC OTG driver for ARM and add it for ARM based SoCs.
Currently it has been tested for Samsung's S5P6440. The development is still 
under process so these are not the best set of patches. They are just for review
and not for merge. Intent of these patches is to show required modifications
to make dwc_otg patches work on ARM.

Following features are tested for basic functions on SMDK6440
board after modifications:
OTG HOST: HID and mass-storage
OTG DEVICE: mass-storage and adb

This patch series is based on below dwc_otg patches
	http://patchwork.ozlabs.org/patch/89560/

To: Tirumala Marri, Felipe Balbi
[PATCH 1/5] USB: DWC OTG: Modification in DWC OTG driver for ARM based SoCs

To: Kukjin Kim
[PATCH 2/5] ARM: SAMSUNG: Changing the build condition of OTG platform device for samsung
[PATCH 3/5] ARM: SAMSUNG: Adding IO mapping for OTG
[PATCH 4/5] ARM: S5P64x0: Adding OTG PHY control code
[PATCH 5/5] ARM: S5P64x0: Adding OTG device and initialization code for smdk6440
