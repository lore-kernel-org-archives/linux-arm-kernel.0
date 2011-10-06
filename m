From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Oct 2011 15:19:01 +0300
Subject: [PATCH 01/26] usb/gadget/pxa25x: is_vbus_present is gone
In-Reply-To: <1317499438-14058-2-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-2-git-send-email-arnd@arndb.de>
Message-ID: <20111006121900.GQ1714@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 01, 2011 at 10:03:33PM +0200, Arnd Bergmann wrote:
> A recent commit obsoleted the is_vbus_present function, so
> we must not use it any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>

If you want to carry this through your tree, I'm fine with it:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111006/25b7f08e/attachment.sig>
