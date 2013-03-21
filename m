From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 21 Mar 2013 11:22:27 -0500
Subject: [PATCH for 3.8+] drivers/video/ep93xx-fb.c: fix missing
 declaration of devm_ioremap()
In-Reply-To: <1363876715-22039-1-git-send-email-hauke@hauke-m.de>
References: <1363876715-22039-1-git-send-email-hauke@hauke-m.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020980225826@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 21, 2013 7:39 AM, Hauke Mehrtens wrote:
> This fixes the following compile error:
> drivers/video/ep93xx-fb.c: In function 'ep93xxfb_probe':
> drivers/video/ep93xx-fb.c:532:2: error: implicit declaration of function 'devm_ioremap' [-Werror=implicit-function-declaration]
> drivers/video/ep93xx-fb.c:532:17: warning: assignment makes pointer from integer without a cast [enabled by default]
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: stable at vger.kernel.org

This patch is already in Andrew Morton's -mm tree.


Ryan,

Maybe you should pick this up in your fixes branch?

Regards,
Hartley
