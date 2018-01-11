From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jan 2018 13:18:15 +0100
Subject: [PATCH v2 07/12] drm/sun4i: Add has_channel_0 TCON quirk
In-Reply-To: <20180110192512.19684-8-jernej.skrabec@siol.net>
References: <20180110192512.19684-1-jernej.skrabec@siol.net>
 <20180110192512.19684-8-jernej.skrabec@siol.net>
Message-ID: <20180111121815.lzhfy7n7uppamznj@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 08:25:07PM +0100, Jernej Skrabec wrote:
> Some TCONs on newer SoCs doesn't support channel 0, since they are meant
> to be used only with TV or HDMI encoder.
> 
> Prepare support for them with adding has_channel_0 quirk.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/3ff9eab4/attachment.sig>
