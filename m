From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 14:35:07 +0200
Subject: [PATCH] drm/sun4i: Use (struct drm_format_info) fields to
 determine if a format is yuv and multi planar or not.
In-Reply-To: <1532336220-3791-1-git-send-email-ayan.halder@arm.com>
References: <1532336220-3791-1-git-send-email-ayan.halder@arm.com>
Message-ID: <20180724123507.rqnq4dkjjvk24w4t@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 09:57:00AM +0100, Ayan Kumar Halder wrote:
> We do not need sun4i_backend_format_is_packed_yuv422() /
> sun4i_backend_format_is_planar_yuv() to determine if the format is yuv multi planar
> or not. (struct drm_format_info *)->is_yuv tells if the format is yuv or not.
> And (struct drm_format_info *)->num_planes denotes the number of planes.
> 
> This issue was identified during a review on a previous patch:-
> https://lists.freedesktop.org/archives/dri-devel/2018-July/183840.html
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/4e7a4103/attachment-0001.sig>
