From: tj@kernel.org (Tejun Heo)
Date: Sun, 22 Sep 2013 17:48:59 -0400
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <523F3567.80303@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <523F3567.80303@cogentembedded.com>
Message-ID: <20130922214859.GC27616@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Sep 22, 2013 at 10:22:31PM +0400, Sergei Shtylyov wrote:
> >@@ -37,6 +37,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/libata.h>
> >+#include <linux/phy/phy.h>
> 
> struct phy;
> 
> should suffice.

Unless it's actually likely to cause inclusion loop, I think it's
better to include the header than adding explicit declarations.

Thanks.

-- 
tejun
