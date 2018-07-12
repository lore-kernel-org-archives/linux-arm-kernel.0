From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 09:35:10 +0200
Subject: [PATCH v3] drm/sun4i: mixer: Read id from DT
In-Reply-To: <20180711112706.30222-1-jernej.skrabec@siol.net>
References: <20180711112706.30222-1-jernej.skrabec@siol.net>
Message-ID: <20180712073510.ssl43bjgv5n5mrwb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 01:27:06PM +0200, Jernej Skrabec wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
> 
> However, for R40, only the new way will be used. To prepare for that,
> implement mixer id fetching from DT.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/c7f270c9/attachment.sig>
