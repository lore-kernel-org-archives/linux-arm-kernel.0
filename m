From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:41:50 +0100
Subject: [PATCH 09/77] ARM: dts: sun5i: Change LRADC node names to avoid
 warnings
In-Reply-To: <CAGb2v66RkOWMVxwJ5BzDywXwKnDquvFvgcfCwF0ViwoyZPzUGg@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <8fa5b2c6c2eb9105ea8e388f2f952ecffbdf1f02.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66RkOWMVxwJ5BzDywXwKnDquvFvgcfCwF0ViwoyZPzUGg@mail.gmail.com>
Message-ID: <20181128104150.aukfoehnzgpijjhy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:06:19AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > One of the usage of the LRADC is to implement buttons. The bindings define
> > that we should have one subnode per button, with their associated voltage
> > as a property.
> >
> > However, there was no reg property but we still used the voltage associated
> > to the button as the unit-address, which eventually generated warnings in
> > DTC.
> >
> > Rename the node names to avoid those warnings.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/5440dbdd/attachment-0001.sig>
