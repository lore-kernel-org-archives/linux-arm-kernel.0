From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:41:13 +0100
Subject: [PATCH 30/77] ARM: dts: sun6i: Remove redundant MMC pinmux tuning
In-Reply-To: <CAGb2v64TnAO24=ZERUULutkuL+Ex2QGmxhMyj-e_mU7uMhYVhA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f0fedb9e722eb18306d0a33e7997f90910417b17.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64TnAO24=ZERUULutkuL+Ex2QGmxhMyj-e_mU7uMhYVhA@mail.gmail.com>
Message-ID: <20181128134113.wp3bbssxzhipzd25@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:46:45PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Some boards override the MMC pin muxing settings in order to enable the
> > pull-ups and change the drive strength to a value higher than the default.
> >
> > While this was needed in the earlier days, this is now the default setting
> > for those pins, and therefore we don't need those board-specific settings
> > anymore.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/144cc9ee/attachment-0001.sig>
