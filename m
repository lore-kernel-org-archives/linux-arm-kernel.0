From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 10:13:21 +0100
Subject: [PATCH RFC] drm/sun4i: Enable the output on the pins (tcon0)
In-Reply-To: <20180222161217.23904-1-megous@megous.com>
References: <20180222161217.23904-1-megous@megous.com>
Message-ID: <20180226091321.b5dqdlsiq2eyix7c@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 05:12:17PM +0100, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> I noticed that with 4.16-rc1 LVDS output on A83T based TBS A711 tablet doesn't
> work (there's output but it's garbled). I compared some older patches for LVDS
> support with the mainlined ones and this change is missing from mainline Linux.
> 
> I don't know what the register does exactly and the harcoded register value
> doesn't inspire much confidence that it will work in a general case, so I'm
> sending this RFC.
> 
> This patch fixes the issue on A83T.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/342085a6/attachment.sig>
