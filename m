From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Feb 2018 22:15:07 +0800
Subject: [PATCH v3 8/8] drm/sun4i: backend: Remove ARGB spoofing
In-Reply-To: <965180afd8169ccaa848f061d16a2c1a9ec4d289.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <965180afd8169ccaa848f061d16a2c1a9ec4d289.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v658h+MKv--py2cZdUp_iDje9MBSe8vOXBfgyoHRPyz_5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 1:39 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> We've had some code for quite some time to prevent the alpha bug from
> happening on the lowest primary plane. Since we now check for this in our
> atomic_check, we can simply remove it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
