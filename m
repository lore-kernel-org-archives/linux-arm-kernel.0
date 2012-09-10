From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:24:49 -0700
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20120910161428.879618aea62e5be6340ed93c@canb.auug.org.au>
References: <20120910161428.879618aea62e5be6340ed93c@canb.auug.org.au>
Message-ID: <CACRpkdbf94QG59pvqcN_grCG_tcpri7JyypZ9ZMu3R=LwvSoXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 8:14 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the clk tree got a conflict in
> arch/arm/mach-ux500/clock.c between commit 79964bcd792f ("ARM: ux500:
> Correct Ux500 family names usage") from the arm-soc tree and commit
> ebc96db7632f ("ARM: ux500: Switch to use common clock framework") from
> the clk tree.
>
> The latter removed the file so I did that - there may be more fixup
> required.

This is the correct solution, thanks!

Yours,
Linus Walleij
