From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 20 May 2013 09:05:10 +0800
Subject: [PATCH] Change internal SRAM memory type to "MT_MEMORY_SO"
Message-ID: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This patch is to change the internal SRAM memory type to "MT_MEMORY_SO", the right type.

It tested on sama5d3xek boards.

It based on v3.10-rc1.

Best Regards,
Wenyou Yang

Wenyou Yang (1):
  ARM: at91: Fix: Change internal SRAM memory type to "MT_MEMORY_SO"

 arch/arm/mach-at91/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5
