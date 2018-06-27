From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 27 Jun 2018 20:25:00 +0200
Subject: [PATCH] drm/sun4i: Implement zpos for DE2
In-Reply-To: <20180627164514.4777-1-jernej.skrabec@siol.net>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
Message-ID: <20180627182500.eanqagmcfmsgzos2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> Initial implementation of DE2 planes only supported fixed zpos.
> 
> Expand implementation with configurable zpos property.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks for that work. I guess you should expand a bit on the exact
setup you're doing here.

Are the pipes working the same way on the DE2 than on DE1, ie does the
pipe blending applies before the alpha blending, and therefore you
need to make sure that there's not two planes with alpha going to the
same pipe?

Also, you seem to use the pipe and channels indifferently now, why is
that?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/22a7ac37/attachment.sig>
