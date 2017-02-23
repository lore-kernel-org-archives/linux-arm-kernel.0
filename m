From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:30:23 -0800
Subject: [PATCH 11/11] drm/sun4i: Add backend and tcon pointers to
 sun4i_crtc
In-Reply-To: <20170223080543.6659-12-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-12-wens@csie.org>
Message-ID: <20170223183023.6mtafahkb4axl7ei@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:43PM +0800, Chen-Yu Tsai wrote:
> sun4i_crtc controls the backend and tcon hardware blocks of the display
> pipeline. Instead of doing so through the master drm structure, leave
> pointers to the corresponding backend and tcon in itself.
> 
> Also drop the drm_device pointer, since it is no longer needed.
> 
> The next step forward would be to pass the pointers in through
> sun4i_crtc_init as parameters. This would make it easier to support
> multiple display pipelines layer on.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied all the previous patches, and this one

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/92b70a11/attachment.sig>
