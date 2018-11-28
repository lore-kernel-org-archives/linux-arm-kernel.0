From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:42:14 +0100
Subject: [PATCH 32/77] ARM: dts: sun6i: Remove underscores from nodes names
In-Reply-To: <CAGb2v660hJRggQFkjeAcHO6F5eSmPDjCS0R_S0VdSCiU+gqCNQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <23da5b1409c3d509c34391bb82863aaf7ff39478.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v660hJRggQFkjeAcHO6F5eSmPDjCS0R_S0VdSCiU+gqCNQ@mail.gmail.com>
Message-ID: <20181128134214.7cwkcpdv4dvqdyfl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:51:05PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Some GPIO pinctrl nodes cannot be easily removed, because they would also
> > change the pin configuration, for example to add a pull resistor or change
> > the current delivered by the pin.
> >
> > Those nodes still have underscores and unit-addresses in their node names
> > in our DTs, so adjust their name to remove the warnings. Use that occasion
> > to also fix some poorly chosen node-names.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/996997c8/attachment.sig>
