From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Oct 2011 09:10:41 +0300
Subject: [PATCH 17/30] usb/musb: allow building USB_MUSB_TUSB6010 as a
	module
In-Reply-To: <1317566760-25681-18-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-18-git-send-email-arnd@arndb.de>
Message-ID: <20111010061041.GG31707@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 04:45:47PM +0200, Arnd Bergmann wrote:
> Commit 1376d92f9 "usb: musb: allow musb and glue layers to be modules"
> made the USB_MUSB_TUSB6010 option modular, but actually building
> the driver as a module does not work, so various randconfig builds
> actually fail. This changes all code that depends on the
> option to also check for modular builds, and exports the necessary
> symbols.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>

applied, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111010/b1e00fb9/attachment.sig>
