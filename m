From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:42:45 +0100
Subject: [PATCH 11/77] ARM: dts: sun5i: Remove card detect pull-up
In-Reply-To: <CAGb2v67xAwfnErGh88wgSoJpq=XXZ+s=6pAJ50hS4y7Udi13vA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f3867ba6c6fcfcd95914c5466d376207a66505b9.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67xAwfnErGh88wgSoJpq=XXZ+s=6pAJ50hS4y7Udi13vA@mail.gmail.com>
Message-ID: <20181128104245.mlh7esklgq3ddywx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:29:35AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Boards usually have an external pull-up on the card-detect signal, so
> > there's no need to add another one.
> >
> > This also removes a DTC warning.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/523a418d/attachment.sig>
