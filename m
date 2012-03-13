From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Tue, 13 Mar 2012 12:33:22 +0000
Subject: [PATCH] mtd/gpmi : fix the wrong DMA command.
In-Reply-To: <1331518938-24047-1-git-send-email-b32955@freescale.com>
References: <1331518938-24047-1-git-send-email-b32955@freescale.com>
Message-ID: <1331642159.3595.28.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-03-12 at 10:22 +0800, Huang Shijie wrote:
> The last DMA command of ECC read page is used to disable the BCH module.
> But the original code missed to set the pio[2] which is used to set the
> GPMI_HW_GPMI_ECCCTRL register. fix it now.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/69cc143a/attachment.sig>
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
