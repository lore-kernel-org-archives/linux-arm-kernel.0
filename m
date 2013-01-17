From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 12:58:33 +0200
Subject: [PATCH v6 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
In-Reply-To: <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
References: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
 <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
Message-ID: <20130117105833.GP10814@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 06:03:17PM +0800, Peter Chen wrote:
> As we use platform_device_id for fsl-usb2-udc driver, it needs to
> change clk connection-id, or the related devm_clk_get will be failed.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

do I get Acked-by for this one ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/0e2bdba7/attachment.sig>
