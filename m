From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 08:36:08 +0100
Subject: [PATCH v2 06/16] drm/sun4i: Don't process LVDS if TCON doesn't
 support it
In-Reply-To: <20180227222701.9716-7-jernej.skrabec@siol.net>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <20180227222701.9716-7-jernej.skrabec@siol.net>
Message-ID: <20180228073608.r2zd3qkiudm2uarm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 11:26:51PM +0100, Jernej Skrabec wrote:
> TCON checks for LVDS properties even if it doesn't support it. Add a
> check to skip that part of the code if TCON doesn't support channel 0.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

I have already sent a similar patch here:
https://lists.freedesktop.org/archives/dri-devel/2018-February/166665.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/9345a49d/attachment.sig>
