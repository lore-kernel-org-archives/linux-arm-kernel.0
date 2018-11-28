From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:40:20 +0100
Subject: [PATCH 25/77] ARM: dts: sun6i: Remove SoC node unit-name to
 avoid warnings
In-Reply-To: <CAGb2v66gxk03gKa0kVPmqda3+U0Q5DnK+z+1a8K96VKcayNxOg@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <c7e0a1601f98d7b1a6262784c67cd272d7117f96.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66gxk03gKa0kVPmqda3+U0Q5DnK+z+1a8K96VKcayNxOg@mail.gmail.com>
Message-ID: <20181128134020.3absvdqwo3xaa5qq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:41:00PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Our main node for all the in-SoC controllers used to have a unit name. The
> > unit-name, in addition to being actually false, would not match any reg
> > property, which generates a warning.
> >
> > Remove it in order to remove those warnings.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/cc2b1b32/attachment.sig>
