From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 00:33:36 +0200
Subject: [PATCH 3/4] ARM: dts: sun5i: Add dts file for the Empire
 Electronix M712 tablet
In-Reply-To: <20160826144226.29969-3-hdegoede@redhat.com>
References: <20160826144226.29969-1-hdegoede@redhat.com>
 <20160826144226.29969-3-hdegoede@redhat.com>
Message-ID: <20160826223336.GL3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 04:42:25PM +0200, Hans de Goede wrote:
> Add a dts file for the Empire Electronix M712 tablet, this is a 7" A13
> tablet, with micro-usb (otg), headphone and micro-sd slots on the
> outside. It uses a Goodix gt811 touchscreen controller, a RTL8188CTV
> wifi chip and a DMART06 (1238a4) accelerometer.
> 
> Note currently the dts for this is somewhat empty. This will change
> once we add support for the touchscreen and accelerometer.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks very much for that reference design rework, it makes things
much easier to review :)

Applied.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/ae6bd0e9/attachment.sig>
