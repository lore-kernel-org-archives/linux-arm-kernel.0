From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Feb 2018 22:14:24 +0800
Subject: [PATCH v3 5/8] drm/sun4i: Remove the plane description structure
In-Reply-To: <6b09e3698e692c3338f70a5ae1e5a580f9dd08ee.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <6b09e3698e692c3338f70a5ae1e5a580f9dd08ee.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65VUek6t3p1dwOAWzAEproBkT_SpVVfdYYw4aLYYc+nBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 1:39 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> The plane description structure was mostly needed to differentiate the
> formats usable on the primary plane (because of its lowest position), and
> assign the pipes. Now that both are dynamically checked and assigned, we
> can remove the static definition.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
