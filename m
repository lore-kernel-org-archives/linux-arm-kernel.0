From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 09:51:22 +0100
Subject: [PATCH] drm/sun4i: Fix uninitialized variables in vi layer
In-Reply-To: <20171206152603.25937-1-jernej.skrabec@siol.net>
References: <20171206152603.25937-1-jernej.skrabec@siol.net>
Message-ID: <20171207085122.svfbm7xkd4cxfgvd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 06, 2017 at 04:26:03PM +0100, Jernej Skrabec wrote:
> min_scale and max_scale in sun8i_vi_layer_atomic_check() can be used
> without initialization.
> 
> Fix that.
> 
> Fixes: 	b862a648de3b (drm/sun4i: Add support for HW scaling to DE2)
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

I've applied this, but your fixes tag was at the wrong format. You
should use the one documented here:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

or you can even use the git option to generate it directly.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/30fc57f6/attachment.sig>
