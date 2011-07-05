From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Jul 2011 16:49:32 +0300
Subject: [PATCH 15/15] pxa2[57]x_udc: drop gpio_pullup handling
In-Reply-To: <1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110705134931.GL2820@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 05:08:41PM +0400, Dmitry Eremin-Solenikov wrote:
> Now as all drivers were converted to using gpio-vbus, drop gpio-pullup
> handling from pxa UDC drivers, thus simplifying them a bit.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

for drivers/usb/gadget:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110705/e06a378e/attachment.sig>
