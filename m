From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Mar 2018 15:41:31 +0800
Subject: [PATCH 3/3] drm/sun4i: crtc: Call drm_crtc_vblank_on /
 drm_crtc_vblank_off
In-Reply-To: <20180221125703.4595-3-maxime.ripard@bootlin.com>
References: <20180221125703.4595-1-maxime.ripard@bootlin.com>
 <20180221125703.4595-3-maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65PiqFo2PN+SD0BxhXu78nVAa0CWfH9aQGYcaUsuLargw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 8:57 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Make sure that the CRTC code will call the enable/disable_vblank hooks.
>
> Otherwise, since the refcounting will be off, we might end up in a
> situation where the vblank management functions are called while the CRTC
> is off.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
