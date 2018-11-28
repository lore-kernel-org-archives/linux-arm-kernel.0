From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:36:27 +0100
Subject: [PATCH 14/77] ARM: dts: sunxi: Change default CMA pool node name
In-Reply-To: <CAGb2v64B5RdDXhzRtexRZnXsugq=s5qPr+JZKSv9R-+QJXPS8w@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <1a8583339afbc1e7e3590e5ca134eae2f7284f4f.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64B5RdDXhzRtexRZnXsugq=s5qPr+JZKSv9R-+QJXPS8w@mail.gmail.com>
Message-ID: <20181128133626.oxleo7tlq3rwaylv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:22:02PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The CMA node has a unit address, but no reg property which generates a
> > warning in DTC. Change the node name to reflect its usage and drop the unit
> > address.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/2692d1b4/attachment-0001.sig>
