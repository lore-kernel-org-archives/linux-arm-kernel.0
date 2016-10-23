From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 00:09:32 +0200
Subject: [PATCH 6/8] pinctrl: aspeed-g4: Capture SuperIO pinmux dependency
In-Reply-To: <1477010011.8917.20.camel@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <b5f67ba76018314d08e240f95951751896687d37.1474986045.git-series.andrew@aj.id.au>
 <CACRpkdYLDesENtq2cQBrWQeL6NH+mO_N5Z=e9=gsoZSCE85Jag@mail.gmail.com>
 <1477010011.8917.20.camel@aj.id.au>
Message-ID: <CACRpkdYZPcjGuRKVL6qwof1p7ZXT4EvwzAuz59oTgp9Z5Dzixw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 2:33 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

>> Patch applied for v4.10.
>> (Tell me if I'm applying patches in wrong order or something, and
>> I hope this doesn't clash with the fixes.)
>
> Both this patch and 8/8 functionally depend on 5/8. I fetched the
> pinctrl tree to poke around but this patch didn't appear in any of the
> updated branches, so I'm not sure whether we have the right ordering.
> Without it we should hit build failures from missing macro definitions.
>
> Have you had a chance to look over patch 5/8? Joel wasn't keen on its
> current form, so I would appreciate your input.

Oops backed this patch out.

Will look at 5/8.

Appreciate if you repost the remaining patches in the series based on
v4.9-rc2 once it's out, and I'll rebase the pinctrl tree onto that.

Yours,
Linus Walleij
