From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:40:08 +0100
Subject: [PATCH 24/77] ARM: dts: sun6i: Change clock node names to avoid
 warnings
In-Reply-To: <CAGb2v67CmqbwtVkf9jKdd5+dj8d8w7O9eS5fUfa0BGjVYnBCtQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f38aee5e3754b101f9cf776ab42a880e0d57ffbf.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67CmqbwtVkf9jKdd5+dj8d8w7O9eS5fUfa0BGjVYnBCtQ@mail.gmail.com>
Message-ID: <20181128134008.r5lkahhcltfm7sjh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:40:48PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Our oscillators clock names have a unit address, but no reg property, which
> > generates a warning in DTC. Change these names to remove those unit
> > addresses.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/2f476046/attachment.sig>
