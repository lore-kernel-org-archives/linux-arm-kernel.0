From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 10:57:21 +0100
Subject: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
In-Reply-To: <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180301095721.4iga7dcgg566j44m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 06:53:52PM +0100, Giulio Benetti wrote:
>  static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
>  	.get_modes	= sun4i_lvds_get_modes,
> +	.mode_valid	= sun4i_lvds_mode_valid,
>  };

This should be on the encoder, not the connector.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/d67f93cf/attachment-0001.sig>
