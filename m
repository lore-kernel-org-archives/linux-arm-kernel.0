From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:41:38 +0100
Subject: [PATCH 08/77] ARM: dts: sun5i: Remove redundant
 interrupt-controller
In-Reply-To: <CAGb2v64ckTAZDPV3S9SA458HbeBX3V7A3cTK2-8c4JKA3HF8gg@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <56b1dd7aa2ad7cb02edae229968af30871760899.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64ckTAZDPV3S9SA458HbeBX3V7A3cTK2-8c4JKA3HF8gg@mail.gmail.com>
Message-ID: <20181128104138.mimlngrad5hsd6dn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:05:42AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The interrupt-parent property is set in sun5i.dtsi, so there's no need to
> > repeat it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/cdef7ff6/attachment-0001.sig>
