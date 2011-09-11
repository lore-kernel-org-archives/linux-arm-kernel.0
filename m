From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Sep 2011 23:12:52 +0200
Subject: [PATCH v4] mach-realview: expose PB1176 ROM using physmap and
	map_rom
In-Reply-To: <1315747783.18731.59.camel@sauron>
References: <1315292023-4125-1-git-send-email-linus.walleij@stericsson.com>
	<1315747783.18731.59.camel@sauron>
Message-ID: <CACRpkdb7Qp527PqGT_kT5DF48ajvYgAMazw-sKyeT6hMegrXzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2011 at 3:29 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Tue, 2011-09-06 at 08:53 +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This exposes the PB1176 ROM if you compile in the MTD physmap
>> mapping and also the map_rom chiptype.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>
> I think this should go in via the corresponding arm subtree.

Sure, but I think we need some nod from the MTD people that this is the
right way to present a ROM, so is that an Acked-by?

Yours,
Linus Walleij
