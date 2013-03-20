From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Mar 2013 15:09:27 +0200
Subject: [PATCH 2/6] usb: otg: mv_otg: remove unused clock
In-Reply-To: <1363593333-6077-3-git-send-email-chao.xie@marvell.com>
References: <1363593333-6077-1-git-send-email-chao.xie@marvell.com>
 <1363593333-6077-3-git-send-email-chao.xie@marvell.com>
Message-ID: <20130320130927.GT29659@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 03:55:29AM -0400, Chao Xie wrote:
> The origianl understanding of clock is wrong. The OTG controller
> only have one clock input.
> Passing clock name by pdata is wrong. The clock is defined by device
> iteself.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

please rebase against my 'next' branch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130320/d782bc71/attachment.sig>
