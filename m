From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 12:37:29 +0200
Subject: [PATCH 1/2] USB mxs-phy: Register phy with framework
In-Reply-To: <1359631937-26646-2-git-send-email-s.hauer@pengutronix.de>
References: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
 <1359631937-26646-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130214103729.GC15537@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 31, 2013 at 12:32:16PM +0100, Sascha Hauer wrote:
> We now have usb_add_phy_dev(), so use it to register with the framework
> to be able to find the phy from the USB driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha, are you taking this through your tree or you want me to queue it
up ?

If you want to take it:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/3b0a8117/attachment.sig>
