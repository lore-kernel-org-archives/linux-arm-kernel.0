From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Feb 2018 15:34:50 +0100
Subject: [PATCH v3 7/8] drm/sun4i: Add support for plane alpha
In-Reply-To: <CAGb2v66W0W1V8_SaRn2nvkptPht5nYXEvJThf1hY5qJPo+zPwA@mail.gmail.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <76eeabd20aeff78f2cd434eb25a0d2a37528ea57.1518802627.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66W0W1V8_SaRn2nvkptPht5nYXEvJThf1hY5qJPo+zPwA@mail.gmail.com>
Message-ID: <20180222143450.gr3tom2ahdimdurd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 10:17:38PM +0800, Chen-Yu Tsai wrote:
> On Sat, Feb 17, 2018 at 1:39 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Our backend supports a per-plane alpha property. Support it through our new
> > helper.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Though, not having a graphics background, does alpha = 255 mean fully
> transparent and thus can be skipped? Or no alpha at all?

It means that it's fully opaque, and therefore we are in the same
situation than if we had no alpha channel at all.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/d903d0bf/attachment.sig>
