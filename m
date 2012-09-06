From: mturquette@ti.com (Mike Turquette)
Date: Thu, 06 Sep 2012 16:25:17 -0700
Subject: [PATCH V2 0/4] clk: Convert ARM ux500 to common clock
In-Reply-To: <CACRpkdbH-vCfAYavO4Ef78Dy1dnphXc+JD76YHAhOiORsCWFHA@mail.gmail.com>
References: <1346075153-14180-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdbH-vCfAYavO4Ef78Dy1dnphXc+JD76YHAhOiORsCWFHA@mail.gmail.com>
Message-ID: <20120906232517.20289.46469@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-08-27 17:02:53)
> On Mon, Aug 27, 2012 at 6:45 AM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> 
> > This converts the ux500 machine specific clocks to the common
> > clock framework. Old clock code are then removed from the ux500
> > machine directory.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> For this whole patch set, Mike when you're pleased with the looks of this I'd
> be very happy if you could merge this to your tree for some rotation
> in linux-next....
> 

I've pulled it into clk-next.  Predictably ux500_defconfig breaks since
cpu_is_u8540 does not exist in my code.  Merging clk-next onto latest
linux-next shows that everything builds nicely (well the are some
warnings but nothing dire...).

Regards,
Mike

> Yours,
> Linus Walleij
