From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 16 Apr 2018 21:54:48 +0200
Subject: [PATCH v6 0/5] drm/blend: Support generic plane-wide alpha
In-Reply-To: <cover.637c90251afd1eb6d5564a3c50beda2a3d51160a.1523432341.git-series.maxime.ripard@bootlin.com>
References: <cover.637c90251afd1eb6d5564a3c50beda2a3d51160a.1523432341.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180416195448.hwnt3tv27twecbw6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 09:39:24AM +0200, Maxime Ripard wrote:
> Hi,
> 
> This serie aims at enhancing the support for plane-wide alpha in the
> drivers that are implementing it at the moment, by turning it into a
> generic property and converting the drivers (rcar-du and atmel-hclcdc). It
> also introduces support for it in the sun4i driver.

Applied with Sean and Maarten's Acked-by, as reported on IRC.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180416/c9d5801e/attachment.sig>
