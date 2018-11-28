From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:39:58 +0100
Subject: [PATCH 23/77] ARM: dts: sun6i: Change framebuffer node names to
 avoid warnings
In-Reply-To: <CAGb2v656w-p9gEkqfR0V_YSO+mpr51qR3oRybS3z8bhpwsXiow@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <92add4869d5738cf12766e3ca7ee379d3177397b.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v656w-p9gEkqfR0V_YSO+mpr51qR3oRybS3z8bhpwsXiow@mail.gmail.com>
Message-ID: <20181128133958.3eow7ukks3ekwrc2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:40:32PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The simple-framebuffer nodes have a unit address, but no reg property which
> > generates a warning when compiling it with DTC.
> >
> > Change the simple-framebuffer node names so that there is no warnings on
> > this anymore.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/ba55afdb/attachment.sig>
