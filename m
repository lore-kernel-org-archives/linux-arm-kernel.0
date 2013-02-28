From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Feb 2013 10:01:27 +0200
Subject: [PATCH 3/3] USB mxs-phy: Register phy with framework
In-Reply-To: <1361974590-21237-4-git-send-email-mkl@pengutronix.de>
References: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
 <1361974590-21237-4-git-send-email-mkl@pengutronix.de>
Message-ID: <20130228080127.GB6544@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Wed, Feb 27, 2013 at 03:16:30PM +0100, Marc Kleine-Budde wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> We now have usb_add_phy_dev(), so use it to register with the framework
> to be able to find the phy from the USB driver.
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Peter Chen <peter.chen@freescale.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

any chance you can move away from {write,read}[bwl]_relaxed() so we can
build this driver on other architectures ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/39aa4809/attachment.sig>
