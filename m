From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jun 2016 10:19:35 +0200
Subject: [PATCH] ARM: dts: sun8i-q8-common: Add support for USB wifi
 controllers
In-Reply-To: <1466015030-18091-1-git-send-email-hdegoede@redhat.com>
References: <1466015030-18091-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160616081935.GI5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 08:23:50PM +0200, Hans de Goede wrote:
> Some of the sun8i q8 boards have an usb wifi controller, on other
> variants this will result in an used usb root-hub, but the best
> way to deal with wifi on this boards is to simply let the kernel
> auto-detect usb or sdio wifi controllers.
> 
> This has been tested on an a23 based q8 tablet with a RTL8188ETV wifi
> controller.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160616/1ff6172a/attachment.sig>
