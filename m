From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 16 Feb 2012 12:27:48 +0200
Subject: [PATCHv9 0/5] arm: omap: smps regulator support
Message-ID: <1329388073-17879-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following changes compared to previous version:

- updated to work with mainline
- added acked-by Samuel Ortiz to patch 4 MFD part (no changes done to that
  part of code since previous version)
- changed min_uV parameter name from patch 4/5 to target_uV

Tested with omap3 beagle: changed + measured voltages manually for
vdd1 and vdd2.

-Tero
