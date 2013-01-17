From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 13:50:46 +0200
Subject: [PATCH v7 22/22] mdf: omap-usb-host: get rid of build warning
In-Reply-To: <1358422231-24736-23-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-23-git-send-email-rogerq@ti.com>
Message-ID: <20130117115046.GI18978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 01:30:31PM +0200, Roger Quadros wrote:
> Fixes the below build warning when driver is built-in.
> 
> drivers/mfd/omap-usb-host.c:750:12: warning:
> ?usbhs_omap_remove? defined but not used [-Wunused-function]
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

should this go to stable too ?

(though it's not really a bug, so doesn't really matter, I guess).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/87e1ca1a/attachment.sig>
