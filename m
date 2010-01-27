From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 27 Jan 2010 15:00:49 +0200
Subject: [PATCH 3/3] mx25pdk: platform code for the DryIce RTC module
In-Reply-To: <cover.1264596212.git.baruch@tkos.co.il>
References: <cover.1264596212.git.baruch@tkos.co.il>
Message-ID: <52156998a9cdc3d730e8cace5d158e849750c5d3.1264596212.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/mx25pdk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index 232f9ca..f4e8b98 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -91,6 +91,7 @@ static void __init mx25pdk_init(void)
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_usbh2, NULL);
 	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
+	mxc_register_device(&mx25_rtc_device, NULL);
 
 	mx25pdk_fec_reset();
 	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
-- 
1.6.5
