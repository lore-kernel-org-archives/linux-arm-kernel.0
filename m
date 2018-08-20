From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 13:52:44 +0200
Subject: [PATCH] drm: sun4i: exclusively set HDMI-related clocks for
 dw-hdmi
In-Reply-To: <20180815120745.36593-1-icenowy@aosc.io>
References: <20180815120745.36593-1-icenowy@aosc.io>
Message-ID: <20180820115244.x5z6lm4i7tpqptgs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Aug 15, 2018 at 08:07:45PM +0800, Icenowy Zheng wrote:
> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
> dw-hdmi exclusively, which will lead the display fails to initialize in
> some situations.

Apart from the feedback already given, detailing which situations
would be very helpful.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/c6d233ed/attachment.sig>
