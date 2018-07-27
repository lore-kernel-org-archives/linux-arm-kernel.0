From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 27 Jul 2018 14:54:49 +0200
Subject: [PATCH v2 08/10] drm/sun4i: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180726161756.1794-9-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
 <20180726161756.1794-9-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180727125449.iyoocim6s3sniyf7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 05:17:54PM +0100, Alexandru Gheorghe wrote:
> A new helper function(__drm_atomic_helper_plane_reset) has been added
> for linking a plane with its state and resetting the core
> properties(alpha, rotation, etc.) to their default values.
> Use that instead of duplicating the logic.
> 
> __drm_atomic_helper_plane_reset initializes the alpha property to its
> max value, which is defined by the drm core as DRM_BLEND_ALPHA_OPAQUE,
> so nothing changes regarding the alpha value.
> 
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/b0c4557b/attachment.sig>
