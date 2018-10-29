From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:17:07 +0100
Subject: [PATCH v3 06/25] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic
 short write 2 param transfer
In-Reply-To: <20181026144344.27778-7-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-7-jagan@amarulasolutions.com>
Message-ID: <20181029091707.shfxcqe5xchoqjqw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:13:25PM +0530, Jagan Teki wrote:
> Short transfer write support for DCS and Generic transfer types
> share similar way to process command sequence in DSI block so
> add generic write 2 param transfer type macro so-that the panels
> which are requesting similar transfer type may process properly.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>

I'm not sure why you have a Tested-by tag here. Of course we're
expecting you to test your patches before sending them.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/626a2cfa/attachment.sig>
