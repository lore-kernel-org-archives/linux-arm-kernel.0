From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 15:26:06 +0200
Subject: [PATCH 0/40] ARM: ux500: Convert to Device Tree only platform
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda8qaNa09OLzsrK2KXzaFx-nwWr0pJpehN5qWtuKTORsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 2:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> I started by taking out simple, unimportant pieces, then finalised by
> removing the critical booting components required for booting with
> ATAGs. After this patch-set the ux500 will only boot with Device Tree
> enabled. DT boot appears to be unaffected by the work, tested on
> Snowball.

Overall a very nice pice-by-piece approach, thanks!

We need to CLK DT stuff sorted out and applied first though.

I think we can just go ahead and start applying first the clk DT
and then this as a first take for v3.13 after the merge window.
(It's way too late for v3.12.)

Yours,
Linus Walleij
