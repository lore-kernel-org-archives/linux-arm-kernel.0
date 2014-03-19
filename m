From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Mar 2014 14:11:08 -0700
Subject: [PATCH 20/62] ARM: msm: add missing include of linux/module.h
In-Reply-To: <1395257399-359545-21-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-21-git-send-email-arnd@arndb.de>
Message-ID: <20140319211108.GA10102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:17PM +0100, Arnd Bergmann wrote:
>After the restructuring of the module.h and init.h headers,
>we now need to include this explicitly here.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>Cc: David Brown <davidb@codeaurora.org>
>Cc: Daniel Walker <dwalker@fifo99.com>
>Cc: Bryan Huntsman <bryanh@codeaurora.org>
>---
> arch/arm/mach-msm/dma.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: David Brown <davidb@codeaurora.org>

>diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
>index f8f6adf..ba62f02 100644
>--- a/arch/arm/mach-msm/dma.c
>+++ b/arch/arm/mach-msm/dma.c
>@@ -18,6 +18,7 @@
> #include <linux/io.h>
> #include <linux/interrupt.h>
> #include <linux/completion.h>
>+#include <linux/module.h>
> #include <mach/dma.h>
> #include <mach/msm_iomap.h>
>
>-- 
>1.8.3.2
>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
