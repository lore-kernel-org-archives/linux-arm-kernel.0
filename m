From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 13 Sep 2015 18:10:37 +0200
Subject: [PATCH 2/2] ARM: dts: sun5i: Add dts file for the Wobo i5 top
 set box
In-Reply-To: <1441890359-4675-2-git-send-email-hdegoede@redhat.com>
References: <1441890359-4675-1-git-send-email-hdegoede@redhat.com>
 <1441890359-4675-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150913161037.GX9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 03:05:59PM +0200, Hans de Goede wrote:
> From: Jelle van der Waa <jelle@vdwaa.nl>
> 
> The Wobo i5 top set box is a somewhat curious A10s based top set box,
> it uses an AXP209 rather then the AXP152 usually used in combination
> with the A10s. It has an ethernet phy connected to PORTD rather then
> PORTA, and its built-in usb wifi is connected via the otg controller.
> 
> This commit adds a dts file adding support for this top set box.
> 
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied both, thanks!

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150913/6288ee7f/attachment.sig>
