From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:38:51 +0100
Subject: [PATCH 18/77] ARM: dts: sun5i: Fix Display Engine DTC warnings
In-Reply-To: <CAGb2v65ew5Nh9syqgzx+OYRJ2NJNKiNbsyutR_GDzKznpbD=bQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f2dbd10e7c99093198e133197e3cd5ad07cf7256.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v65ew5Nh9syqgzx+OYRJ2NJNKiNbsyutR_GDzKznpbD=bQ@mail.gmail.com>
Message-ID: <20181128133851.tl5pviw4qaerhpdz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:30:52PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Our display engine endpoints trigger some DTC warnings due to the fact that
> > we're having a single endpoint that doesn't need any reg property, and
> > since we don't have a reg property, we don't need the address-cells and
> > size-cells properties anymore.
> >
> > Fix those
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/d77fbf6d/attachment.sig>
