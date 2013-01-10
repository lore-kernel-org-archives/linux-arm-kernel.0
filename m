From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 12:29:15 +0200
Subject: [V2 PATCH 08/27] usb: gadget: mv_udc: fix the value of tranceiver
In-Reply-To: <1354071986-28032-9-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <1354071986-28032-9-git-send-email-chao.xie@marvell.com>
Message-ID: <20130110102915.GF28920@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:06:07PM -0500, Chao Xie wrote:
> usally we will use udc->tranceiver == NULL or
> udc->tranceiver != NULL.
> So when failed to get the udc->tranceiver by usb_get_phy(), we
> directly set udc->tranceiver to be NULL.
> Then the source code will not need macro IS_ERR_OR_NULL() for
> udc->tranceiver judgement. It can reduce the line size and make
> the judgement simple.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

care to refresh ?

patching file drivers/usb/gadget/mv_udc_core.c
Hunk #1 succeeded at 1408 with fuzz 2 (offset 14 lines).
Hunk #2 FAILED at 2174.
Hunk #3 succeeded at 2363 (offset 44 lines).
Hunk #4 succeeded at 2442 with fuzz 1 (offset 56 lines).
Hunk #5 succeeded at 2475 with fuzz 1 (offset 54 lines).
1 out of 5 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc_core.c.rej

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/9b6efbae/attachment.sig>
