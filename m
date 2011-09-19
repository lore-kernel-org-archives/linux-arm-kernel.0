From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 19 Sep 2011 07:11:14 +0300
Subject: [PATCH v4] mach-realview: expose PB1176 ROM using physmap and
	map_rom
In-Reply-To: <CACRpkdb7Qp527PqGT_kT5DF48ajvYgAMazw-sKyeT6hMegrXzQ@mail.gmail.com>
References: <1315292023-4125-1-git-send-email-linus.walleij@stericsson.com>
	<1315747783.18731.59.camel@sauron>
	<CACRpkdb7Qp527PqGT_kT5DF48ajvYgAMazw-sKyeT6hMegrXzQ@mail.gmail.com>
Message-ID: <1316405483.24366.15.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-09-11 at 23:12 +0200, Linus Walleij wrote:
> On Sun, Sep 11, 2011 at 3:29 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > On Tue, 2011-09-06 at 08:53 +0200, Linus Walleij wrote:
> >> From: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> This exposes the PB1176 ROM if you compile in the MTD physmap
> >> mapping and also the map_rom chiptype.
> >>
> >> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> >
> > I think this should go in via the corresponding arm subtree.
> 
> Sure, but I think we need some nod from the MTD people that this is the
> right way to present a ROM, so is that an Acked-by?

Acked-by: Artem Bityutskiy <artem.bityutskiy@intel.com>

-- 
Best Regards,
Artem Bityutskiy
