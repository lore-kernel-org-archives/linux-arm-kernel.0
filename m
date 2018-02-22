From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Feb 2018 22:17:38 +0800
Subject: [PATCH v3 7/8] drm/sun4i: Add support for plane alpha
In-Reply-To: <76eeabd20aeff78f2cd434eb25a0d2a37528ea57.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <76eeabd20aeff78f2cd434eb25a0d2a37528ea57.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66W0W1V8_SaRn2nvkptPht5nYXEvJThf1hY5qJPo+zPwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 1:39 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Our backend supports a per-plane alpha property. Support it through our new
> helper.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Though, not having a graphics background, does alpha = 255 mean fully
transparent and thus can be skipped? Or no alpha at all?

Thanks
