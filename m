From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 28 Nov 2010 19:55:17 +0200
Subject: [PATCH 2/4] mtd: FSMC NAND replace all use of uintNN_t with uN
In-Reply-To: <AANLkTi=ks+ekjgJnb2pv0LaDzPZike+M+QLeOZKkb3iW@mail.gmail.com>
References: <1290201121-15263-1-git-send-email-linus.walleij@stericsson.com>
	<1290788695.2552.35.camel@localhost>
	<AANLkTi=ks+ekjgJnb2pv0LaDzPZike+M+QLeOZKkb3iW@mail.gmail.com>
Message-ID: <1290966917.2032.17.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-11-28 at 11:20 +0100, Linus Walleij wrote:
> 2010/11/26 Artem Bityutskiy <dedekind1@gmail.com>:
> 
> > On Fri, 2010-11-19 at 22:12 +0100, Linus Walleij wrote:
> >> The short kernel versions of the basic types makes the world more
> >> readable.
> >>
> >> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> >
> > I do not think dwmw2 will merge this one because he often claimed that
> > u32 cannot be better than uint32_t, because the latter is C99 standard,
> > but the former is not. So I'd not do this, at least not at the area he
> > looks after.
> 
> Oh man. Whatever, David shall I respin the patch series without
> this one? The latter patches will surely clash so an early indication
> is appreciated.

I do not know if David will respond, but I recommend to respin without
that path, then I'll take the series to my l2-mtd-2.6 tree, and will
take care of them.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
