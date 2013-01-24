From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 11:08:49 +0200
Subject: [V5 PATCH 07/26] usb: gadget: mv_udc: make mv_udc depends on
 ARCH_MMP or ARCH_PXA
In-Reply-To: <1359009530-28182-8-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
 <1359009530-28182-8-git-send-email-chao.xie@marvell.com>
Message-ID: <20130124090849.GE27304@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 24, 2013 at 01:38:31AM -0500, Chao Xie wrote:
> Only ARCH_PXA and ARCH_MMP will use mv_udc.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

NAK, you should fix your transceiver dependency. I want these gadget
drivers to compile cleanly on all arches so we make proper use of
linux-next. I have applied up to previous patch in this series and I
won't go any further. The rest will be delayed for v3.10

sorry

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/e0efef21/attachment.sig>
