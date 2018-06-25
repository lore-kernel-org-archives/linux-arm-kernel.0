From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 25 Jun 2018 18:43:01 +0200
Subject: [PATCH v3 00/24] Add support for R40 HDMI pipeline
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Message-ID: <20180625164300.vivzyu3g52d2pjdn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> This series adds support for R40 HDMI pipeline. It is a bit special
> than other already supported pipelines because it has additional unit
> called TCON TOP responsible for relationship configuration between
> mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> and TV TCONs, TV encoder clock settings and pin muxing between LCD
> and TV encoders.
> 
> However, it seems that TCON TOP will become a norm, since newer
> Allwinner SoCs like H6 also have this unit.
> 
> I tested different possible configurations:
> - mixer0 <> TCON-TV0 <> HDMI
> - mixer0 <> TCON-TV1 <> HDMI
> - mixer1 <> TCON-TV0 <> HDMI
> - mixer1 <> TCON-TV1 <> HDMI
> 
> Please review.

This looks all fine by me, thanks!

I'd still like some more review (by Chen-Yu and Rob) before applying
it, but you can add my Acked-by for the next round if needed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/60ede577/attachment.sig>
