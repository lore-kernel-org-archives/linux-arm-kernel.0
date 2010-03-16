From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:45 +0800
Subject: [PATCH 0/8] pxa: ssp code cleanup
Message-ID: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which includes the following patches:

     [PATCH 1/8] input: remove now deprecated corgi_ts.c touchscreen driver
     [PATCH 2/8] [ARM] pxa: remove now un-used corgi_ssp.c and corgi_lcd.c
     [PATCH 3/8] [ARM] pxa: remove the now legacy SSP API
     [PATCH 4/8] [ARM] pxa: correct SSCR0_SCR to support multiple SoCs
     [PATCH 5/8] [ARM] pxa: merge regs-ssp.h into ssp.h
     [PATCH 6/8] [ARM] pxa: remove unnecessary #include of <mach/ssp.h>
     [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
     [PATCH 8/8] [ARM] pxa: remove incorrect select PXA_SSP in Kconfig
