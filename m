From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:41:04 +0100
Subject: [PATCH 05/77] ARM: dts: sun5i: Change clock node names to avoid
 warnings
In-Reply-To: <CAGb2v67DjRA8hf4PnK_Ep9FP-w1LdL9X9e+5Dhtt0-FwCWeThw@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f46c0b69240d050a52ef2ca4c6c4a73f3f587974.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67DjRA8hf4PnK_Ep9FP-w1LdL9X9e+5Dhtt0-FwCWeThw@mail.gmail.com>
Message-ID: <20181128104104.5tqaevomi5pfpalo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:04:39AM +0800, Chen-Yu Tsai wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/3cb56e3f/attachment.sig>
