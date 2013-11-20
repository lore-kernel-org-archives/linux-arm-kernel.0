From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Nov 2013 10:09:59 +0000
Subject: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
In-Reply-To: <20131120102342.7befe75e@armhf>
References: <cover.1384862950.git.jsarha@ti.com>
 <829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
 <20131120102342.7befe75e@armhf>
Message-ID: <20131120100959.GV2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 10:23:42AM +0100, Jean-Francois Moine wrote:

> But now, I am wondering again about these `empty`codecs:
> - in a DT context, should we continue to add / modify such codecs?
> - what do you think about my generic DT codec? (indeed, I would do a new
>   version according to the previous remarks)

We still want to be able to have users just name the CODEC on their
board rather than have to type in all the details from the datasheet,
if we're going to try to amalgamate the drivers it should still let
people do that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/09c87c68/attachment.sig>
