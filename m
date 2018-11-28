From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:41:01 +0100
Subject: [PATCH 29/77] ARM: dts: sun6i: Remove card detect pull-up
In-Reply-To: <CAGb2v64cd6B1D3=JkZ9cCGHsrycRTVQZ5Ln_sWhs9518-DPStg@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <ad634fe042cbab93dd8bbad1ed868a96e3cb75b4.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64cd6B1D3=JkZ9cCGHsrycRTVQZ5Ln_sWhs9518-DPStg@mail.gmail.com>
Message-ID: <20181128134101.bbs63fttrka4a4uj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:46:20PM +0800, Chen-Yu Tsai wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/d51d30aa/attachment-0001.sig>
