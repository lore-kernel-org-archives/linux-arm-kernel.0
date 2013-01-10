From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 12:26:55 +0200
Subject: [V2 PATCH 01/27] usb: gadget: mv_udc: use udc_start and udc_stop
 functions
In-Reply-To: <1354071986-28032-2-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <1354071986-28032-2-git-send-email-chao.xie@marvell.com>
Message-ID: <20130110102655.GD28920@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:06:00PM -0500, Chao Xie wrote:
> This patches converts the driver into the new style start/stop
> interface. As a result the driver no longer uses the static
> global the_conroller variable.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Care to refresh ?

patching file drivers/usb/gadget/mv_udc_core.c
Hunk #9 FAILED at 2106.
1 out of 15 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc_core.c.rej

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/35aeb311/attachment.sig>
