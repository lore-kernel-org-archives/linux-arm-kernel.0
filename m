From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:39:46 +0100
Subject: [PATCH 22/77] ARM: dts: sun6i: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <CAGb2v654F68su+Y4cH8+R3c8pfGG5CkKdaRXadjvzHuAcPf7GQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <e3a2d4a2babc00b2baac2a3145505ced92e3130d.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v654F68su+Y4cH8+R3c8pfGG5CkKdaRXadjvzHuAcPf7GQ@mail.gmail.com>
Message-ID: <20181128133946.q4uzdueml7nwg44p@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:39:56PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Using skeleton.dtsi will create a memory node that will generate a warning
> > in DTC. However, that node will be created by the bootloader, so we can
> > just remove it entirely in order to remove that warning.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/eb268e57/attachment-0001.sig>
