From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 5 Apr 2017 15:03:58 -0700
Subject: [PATCH 2/2] ARM/clk: move the ICST library to drivers/clk
In-Reply-To: <CACRpkdY2wvae2n-vBmkXwh6rhVWP_pZddJ3e5BZzQO9q5OVzSA@mail.gmail.com>
References: <20170318085944.15899-1-linus.walleij@linaro.org>
 <20170318085944.15899-3-linus.walleij@linaro.org>
 <CACRpkdY2wvae2n-vBmkXwh6rhVWP_pZddJ3e5BZzQO9q5OVzSA@mail.gmail.com>
Message-ID: <20170405220358.GI7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28, Linus Walleij wrote:
> On Sat, Mar 18, 2017 at 9:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This moves the ICST clock divider helper library from
> > arch/arm/common to drivers/clk/versatile so it is maintained
> > with the other clock drivers.
> >
> > We keep the structure as a helper library intact and do not
> > fuse it with the clk-icst.c Versatile ICST clock driver: there
> > may be other users out there that need to use this library for
> > their clocking, and then it will be helpful to keep the
> > library contained. (The icst.[c|h] files could just be moved
> > to drivers/clk/lib or a similar location to share the library.)
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> CLK maintainers: could you ACK this so that I can ask the ARM
> SoC tree to pull in these two patches?
> 
> Or do you prefer to take all patches in the CLK tree so I should
> ask the ARM people to ACK it?
> 

Either way is fine.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
