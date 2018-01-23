From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Jan 2018 10:58:10 +0100
Subject: [PATCH] drm/sun4i: Fix build warnings in sunxi_engine.h
In-Reply-To: <20180122174306.231609-1-seanpaul@chromium.org>
References: <20180122174306.231609-1-seanpaul@chromium.org>
Message-ID: <20180123095810.pkuqgagqs6atnbeg@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 12:42:59PM -0500, Sean Paul wrote:
> Fixes the following build warnings:
> In file included from ../drivers/gpu/drm/sun4i/sun8i_mixer.h:18:0,
>                  from ../drivers/gpu/drm/sun4i/sun8i_vi_scaler.h:13,
>                  from ../drivers/gpu/drm/sun4i/sun8i_vi_scaler.c:12:
> ../drivers/gpu/drm/sun4i/sunxi_engine.h:36:16: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
>          struct drm_crtc_state *old_state);
>                 ^~~~~~~~~~~~~~
> ../drivers/gpu/drm/sun4i/sunxi_engine.h:53:15: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
>         struct drm_crtc_state *state);
>                ^~~~~~~~~~~~~~
> In file included from ../drivers/gpu/drm/sun4i/sun8i_mixer.h:18:0,
>                  from ../drivers/gpu/drm/sun4i/sun8i_ui_scaler.h:12,
>                  from ../drivers/gpu/drm/sun4i/sun8i_ui_scaler.c:12:
> ../drivers/gpu/drm/sun4i/sunxi_engine.h:36:16: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
>          struct drm_crtc_state *old_state);
>                 ^~~~~~~~~~~~~~
> ../drivers/gpu/drm/sun4i/sunxi_engine.h:53:15: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
>         struct drm_crtc_state *state);
>                ^~~~~~~~~~~~~~
> 
> Fixes: 6b8562c86e24 ("drm/sun4i: engine: Create an atomic_begin
> callback")
> Fixes: 656e5f654903 ("drm/sun4i: engine: Add a custom crtc
> atomic_check")
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Sorry for that, I just pushed it.

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180123/a94e6b47/attachment.sig>
