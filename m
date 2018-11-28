From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:36:51 +0100
Subject: [PATCH 16/77] ARM: dts: sun5i: Remove underscores from nodes names
In-Reply-To: <CAGb2v677BcyMdgrY9i7dqTmzZF3cHrxVrVpH8_co4FyHtavV7g@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <afe95c2d468c0ea61ea6f04cb8689115872a5c42.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v677BcyMdgrY9i7dqTmzZF3cHrxVrVpH8_co4FyHtavV7g@mail.gmail.com>
Message-ID: <20181128133651.y4i3i5txzsxuefgd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:25:43PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/fbd15558/attachment.sig>
