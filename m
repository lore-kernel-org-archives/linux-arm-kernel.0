From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Sep 2016 21:54:53 +0200
Subject: [PATCH v2 3/4] pinctrl: sunxi: Remove unsupported PWM channel
 pinmux in H3
In-Reply-To: <CACRpkdb7rr8Lpc6VZ4Ba=_YOwFDqVwwut1w_BDAfYHm6Qp=W_g@mail.gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-4-woogyom.kim@gmail.com>
 <CACRpkdb7rr8Lpc6VZ4Ba=_YOwFDqVwwut1w_BDAfYHm6Qp=W_g@mail.gmail.com>
Message-ID: <20160907195453.GE28134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 07, 2016 at 09:41:19PM +0200, Linus Walleij wrote:
> On Wed, Aug 31, 2016 at 10:25 AM, Milo Kim <woogyom.kim@gmail.com> wrote:
> 
> > H3 has single PWM channel. The second PWM channel is not supported,
> > so the pinctrl function should be removed.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Icenowy Zheng <icenowy@aosc.xyz>
> > Cc: Jens Kuske <jenskuske@gmail.com>
> > Cc: Krzysztof Adamski <k@japko.eu>
> > Cc: linux-gpio at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> 
> Maxime what is your opinion on this patch?

Chen-Yu is the Allwinner co-maintainer, so you can trust his Acked-by,
but you have mine too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/8cd97ef6/attachment.sig>
