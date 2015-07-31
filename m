From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 18:57:36 +0200
Subject: [PATCH v2 1/3] ARM: dts: sun5i: Enable USB DRC on A10s OLinuxIno
 Micro
In-Reply-To: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
References: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150731165736.GH2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 02:53:36PM +0200, Hans de Goede wrote:
> Enable the otg/drc usb controller on the A10s OLinuxIno Micro.
> 
> Note the A10s OlinuxIno Micro always has some voltage on its otg power
> pin, even if the usb-vbus0-regulator is disabled, the leaked voltage is
> enough to make vbus-det always report 1, so we do not use vbus-det on
> this board.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/da603f5e/attachment.sig>
