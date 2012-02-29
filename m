From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Wed, 29 Feb 2012 07:58:20 +0000
Subject: [PATCH] mtd/gpmi : fix compiler warning
In-Reply-To: <1329189724-26100-1-git-send-email-b32955@freescale.com>
References: <1329189724-26100-1-git-send-email-b32955@freescale.com>
Message-ID: <1330502452.3545.81.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-14 at 11:22 +0800, Huang Shijie wrote:
> The gpmi driver selects the MTD_CMDLINE_PARTS directly.
> But we should not select a visible symbol.
> 
> Just remove the select.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/1dc613fc/attachment.sig>
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
