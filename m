From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 12:33:20 +0200
Subject: [V2 PATCH 25/27] usb: gadget: mv_udc: add device tree support
In-Reply-To: <1354071986-28032-26-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <1354071986-28032-26-git-send-email-chao.xie@marvell.com>
Message-ID: <20130110103320.GI28920@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:06:24PM -0500, Chao Xie wrote:
> In original driver, we have callbacks in platform data, and some
> dynamically allocations variables in platform data.
> Now, these blocks are removed, the device tree support is easier
> now.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

care to refresh ?

patching file drivers/usb/gadget/mv_udc.h
Hunk #1 FAILED at 179.
Hunk #2 succeeded at 219 with fuzz 1 (offset -3 lines).
1 out of 2 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc.h.rej
patching file drivers/usb/gadget/mv_udc_core.c
Hunk #1 succeeded at 34 with fuzz 2.
Hunk #2 FAILED at 2154.
Hunk #3 FAILED at 2176.
Hunk #4 FAILED at 2192.
Hunk #5 succeeded at 2513 (offset 46 lines).
Hunk #6 succeeded at 2528 (offset 46 lines).
3 out of 6 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc_core.c.rej

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/136fe1c3/attachment.sig>
