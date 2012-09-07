From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 10:05:08 +0200
Subject: [PATCH V2 0/4] clk: Convert ARM ux500 to common clock
In-Reply-To: <20120906232517.20289.46469@nucleus>
References: <1346075153-14180-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdbH-vCfAYavO4Ef78Dy1dnphXc+JD76YHAhOiORsCWFHA@mail.gmail.com>
 <20120906232517.20289.46469@nucleus>
Message-ID: <CACRpkdYoHJYA81fCVmwMhqFv7a63H27Bn=xk7uscbkHnrykd3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:25 AM, Mike Turquette <mturquette@ti.com> wrote:

> I've pulled it into clk-next.  Predictably ux500_defconfig breaks since
> cpu_is_u8540 does not exist in my code.  Merging clk-next onto latest
> linux-next shows that everything builds nicely (well the are some
> warnings but nothing dire...).

I for one can live with this. The alternative is to merge the entire
world through ARM SoC which isn't all that nice either.

Yours,
Linus Walleij
