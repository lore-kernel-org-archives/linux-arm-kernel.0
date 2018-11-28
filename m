From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:40:24 +0100
Subject: [PATCH 01/77] ARM: dts: sun4i: Fix gpio-keys warning
In-Reply-To: <CAGb2v67GR4bRfhcV929UtCnwfvfoGmry_zeD6kvWMRZYXDCEGA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <7176711cb25c70abfcd6807d90b7e8f368618dc9.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67GR4bRfhcV929UtCnwfvfoGmry_zeD6kvWMRZYXDCEGA@mail.gmail.com>
Message-ID: <20181128104024.t2di3dds5xo74gmt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 10:53:08AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Fix the 'unnecessary #address-cells/#size-cells without "ranges" or child
> > "reg" property' DTC warning for the gpio-keys DT node on A10 boards.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/6e65ebac/attachment.sig>
