From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Jun 2013 18:06:41 +0300
Subject: [RFC PATCH 32/50] usb: gadget: at91_udc: prepare clk before
 calling enable
In-Reply-To: <1370628498-2584-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370628498-2584-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130612150641.GC15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 08:08:18PM +0200, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/cdc9a63f/attachment.sig>
