From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 12:28:08 +0200
Subject: [V2 PATCH 02/27] usb: gadget: mv_udc: use devm_xxx for probe
In-Reply-To: <1354071986-28032-3-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <1354071986-28032-3-git-send-email-chao.xie@marvell.com>
Message-ID: <20130110102808.GE28920@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:06:01PM -0500, Chao Xie wrote:
> use devm_xxx for udc driver probe. So we do need care about
> the resources release in driver remove or failure handling
> in driver probe.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

care to refresh ?

patching file drivers/usb/gadget/mv_udc_core.c
Hunk #1 FAILED at 2115.
Hunk #2 FAILED at 2129.
Hunk #3 FAILED at 2185.
Hunk #4 succeeded at 2279 (offset 14 lines).
Hunk #5 succeeded at 2291 (offset 14 lines).
Hunk #6 succeeded at 2302 (offset 14 lines).
Hunk #7 succeeded at 2330 (offset 14 lines).
Hunk #8 succeeded at 2352 (offset 14 lines).
Hunk #9 succeeded at 2368 (offset 14 lines).
Hunk #10 succeeded at 2380 (offset 14 lines).
Hunk #11 FAILED at 2384.
Hunk #12 FAILED at 2491.
5 out of 12 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc_core.c.rej

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/91fcd2f0/attachment.sig>
