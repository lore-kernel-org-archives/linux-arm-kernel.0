From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Nov 2012 11:10:53 +0100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
In-Reply-To: <20121109133111.1070c1062889461152713978@canb.auug.org.au>
References: <20121109133111.1070c1062889461152713978@canb.auug.org.au>
Message-ID: <CACRpkdavH0hOWtC=T5iKLQ-BJ6h5CzROcYkZ7=nhHSR4hT6hpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2012 at 3:31 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/pinctrl/pinctrl-nomadik.c between commit 241e51ebd3b2
> ("pinctrl/nomadik: make independent of prcmu driver") from the pinctrl
> tree and commit 44e47ccf8ab6 ("Merge branch 'next/multiplatform' into
> for-next") from the arm-soc tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

This looks like the correct fix, thanks a lot Stephen!

Yours,
Linus Walleij
