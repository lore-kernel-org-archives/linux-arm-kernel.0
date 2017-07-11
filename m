From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Jul 2017 21:21:31 +0200
Subject: [PATCH v3] drm/sun4i: Implement drm_driver lastclose to restore
 fbdev console
In-Reply-To: <20170710065504.31497-1-net147@gmail.com>
References: <20170710065504.31497-1-net147@gmail.com>
Message-ID: <20170711192131.mdmkvgxgzo7bwywe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 04:55:04PM +1000, Jonathan Liu wrote:
> The drm_driver lastclose callback is called when the last userspace
> DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
> the fbdev console otherwise the fbdev console will stop working.
> 
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> Cc: stable at vger.kernel.org
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Queued for 4.14, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170711/2138bc72/attachment.sig>
