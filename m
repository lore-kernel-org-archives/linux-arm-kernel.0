From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:37:35 +0100
Subject: [PATCH 10/14] regulator: dts: set proper lradc vref on OLinuXino
 Lime2
In-Reply-To: <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181127093735.amfqfcsxzreajte4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 05:27:51PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The lradc's analog reference voltage is set to 3.0 volt in the
> hardware. This is more or less set in copper for at least lradc0. Set the
> property in the dts to ensure the lradc is referenced properly.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>

I'm not sure why that patch is part of this series, but I applied
it. Thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/8f7df264/attachment.sig>
