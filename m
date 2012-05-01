From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2012 00:56:24 +0200
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
In-Reply-To: <20120501153441.5e101139fb096ef262ff1d2b@canb.auug.org.au>
References: <20120501153441.5e101139fb096ef262ff1d2b@canb.auug.org.au>
Message-ID: <CACRpkdadH_Ju=Nvpem=1nvMBROwjS-ipJcmKTnU9-Hz8SAOBkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2012 at 7:34 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/mfd/ab5500-core.c between commit 9ea969f0d79d ("mfd: Mark const
> init data with __initconst instead of __initdata for ab5500") from the
> mfd tree and commit f76facc2354b ("mfd/ab5500: delete AB5500 support")
> from the arm-soc tree.
>
> The latter removes the file, so I did that.

That's correct, thanks!

Linus Walleij
