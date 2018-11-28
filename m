From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:42:56 +0100
Subject: [PATCH 12/77] ARM: dts: sun5i: Change pinctrl nodes to avoid
 warning
In-Reply-To: <CAGb2v66KJFsO3Z3dVjEMMWGS98trhVEZRLSLnSxUEhXWFTkLew@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <96b9e11cde1c12e1bc05a5d60e0381f7ac25cd89.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66KJFsO3Z3dVjEMMWGS98trhVEZRLSLnSxUEhXWFTkLew@mail.gmail.com>
Message-ID: <20181128104256.lbn3gjgezx36cmtv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:34:37AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > All our pinctrl nodes were using a node name convention with a unit-address
> > to differentiate the different muxing options. However, since those nodes
> > didn't have a reg property, they were generating warnings in DTC.
> >
> > In order to accomodate for this, convert the old nodes to the syntax we've
> > been using for the new SoCs, including removing the letter suffix of the
> > node labels to the bank of those pins to make things more readable.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/ffe34c2d/attachment.sig>
