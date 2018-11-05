From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 11:45:13 +0100
Subject: [PATCH 05/10] drm/sun4i: sun6i_mipi_dsi: Enable burst mode
In-Reply-To: <20181103100900.30313-6-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-6-jagan@amarulasolutions.com>
Message-ID: <20181105104513.gepldzud2kwyp33o@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2018 at 03:38:55PM +0530, Jagan Teki wrote:
> Enable video_mode_burst bit from dsi base control register
> for burst mode display panels.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Shouldn't that be in the previous patch?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/d2c12a6c/attachment.sig>
