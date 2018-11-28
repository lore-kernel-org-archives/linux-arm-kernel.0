From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:40:51 +0100
Subject: [PATCH 28/77] ARM: dts: sun6i: Remove all useless pinctrl nodes
In-Reply-To: <CAGb2v67nz3w_caXTOuF9kuhiq2g8k0uY9afBtRD3wv-gP5GitA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <af84d92ced266a1f2e8eefb194abc5f813884c91.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67nz3w_caXTOuF9kuhiq2g8k0uY9afBtRD3wv-gP5GitA@mail.gmail.com>
Message-ID: <20181128134051.penq4eokngv3tgd2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:45:37PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The gpio pinctrl nodes are redundant and as such useless most of the times.
> > Since they will also generate warnings in DTC, we can simply remove most of
> > them.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/de6c1b89/attachment-0001.sig>
