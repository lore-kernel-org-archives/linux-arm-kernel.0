From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:42:38 +0100
Subject: [PATCH 34/77] ARM: dts: sun6i: Provide default muxing for
 relevant controllers
In-Reply-To: <CAGb2v66PVqb0+GGVjNDeTbnw2du3fRVtMm1=w++_x_n1Y+9PzQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <e6c662ea9e9ed9eecb1c0fa2a48c9bfc32d3802f.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66PVqb0+GGVjNDeTbnw2du3fRVtMm1=w++_x_n1Y+9PzQ@mail.gmail.com>
Message-ID: <20181128134238.6ns6coqa4r6aibq6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:53:35PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The I2C and MMC controllers have only one muxing option in the SoC. In such a
> > case, we can just move the muxing into the DTSI, and remove it from
> > the DTS.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/e682008a/attachment.sig>
