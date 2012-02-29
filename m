From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Wed, 29 Feb 2012 15:08:26 +0000
Subject: [PATCH] mtd :  change the location of the ONFI detected log
In-Reply-To: <1329448957-9756-1-git-send-email-b32955@freescale.com>
References: <1329448957-9756-1-git-send-email-b32955@freescale.com>
Message-ID: <1330528256.3545.124.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-17 at 11:22 +0800, Huang Shijie wrote:
> Some strange nand chip(such as Hynix H27UBG8T2A) can pass the `ONFI` signature
> check. So the log can be printed out even it is not an ONFI nand indeed.
> 
> Change this log to the end of the function. Print out the log only when we
> really detect an ONFI nand.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/fe599200/attachment.sig>
-------------- next part --------------
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
