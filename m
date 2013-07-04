From: voice.shen@atmel.com (Bo Shen)
Date: Thu,  4 Jul 2013 15:16:38 +0800
Subject: [PATCH 0/4] arm: atmel: enable kernel uncompress info output
Message-ID: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch set enable kernel uncompress info output
  - sama5d3
  - at91sam9n12

without this patch set, it won't show following information
---8>---
Uncompressing Linux... done, booting the kernel.
---<8---


Bo Shen (4):
  arm: atmel: sama5: add definition for usart base address
  arm: atmel: include sama5d3.h into hardware.h
  arm: atmel: sama5: enable kernel uncompress info output
  arm: atmel: sam9n12: enable kernel uncompress info output

 arch/arm/mach-at91/include/mach/hardware.h   |    1 +
 arch/arm/mach-at91/include/mach/sama5d3.h    |    8 ++++++++
 arch/arm/mach-at91/include/mach/uncompress.h |   13 +++++++++++++
 3 files changed, 22 insertions(+)

-- 
1.7.9.5
