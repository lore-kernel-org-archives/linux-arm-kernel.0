From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 14:12:27 -0800
Subject: [PATCH 5/7] drm/sun4i: Drop useless assignment in
 sun4i_layers_init
In-Reply-To: <20170217031330.14087-6-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-6-wens@csie.org>
Message-ID: <20170221221227.vv7iwm23b5irnqji@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:28AM +0800, Chen-Yu Tsai wrote:
> The assignment found in the main loop in sun4i_layers_init:
> 
> 	struct sun4i_layer *layer = layers[i];
> 
> is useless as it gets overwritten by the next line:
> 
> 	layer = sun4i_layer_init_one(drm, plane);
> 
> Drop the assignment.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/b961c231/attachment.sig>
