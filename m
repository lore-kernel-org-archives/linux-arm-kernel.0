From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Sep 2012 23:35:41 +0100
Subject: [PATCH 06/24] ARM: integrator: use __iomem pointers for MMIO
In-Reply-To: <CACRpkdYsv7LJj=aJj3y-GhpAMD8PTKdLsYO8KATWevMM4F5MaQ@mail.gmail.com>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-7-git-send-email-arnd@arndb.de>
 <CACRpkdYsv7LJj=aJj3y-GhpAMD8PTKdLsYO8KATWevMM4F5MaQ@mail.gmail.com>
Message-ID: <20120916223541.GA26353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 12:19:11AM +0200, Linus Walleij wrote:
> On Fri, Sep 14, 2012 at 11:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > ARM is moving to stricter checks on readl/write functions,
> > so we need to use the correct types everywhere.
> >
> > This patch has a few small conflicts with stuff in linux-next, which
> > we have to sort out in arm-soc.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> However if Russell applies some of the stuff that is pending
> in his tracker (was pending uncertain acceptance of
> CONFIG_ATAGS, which is merged now) this will likely
> conflict.

I'm actually a little confused... 7514/1 apparantly has a comment from
me on it, but I don't remember making any comments against it - and the
comment is definitely crap for the patch.  I certainly wasn't processing
patches at 20:38 on Friday 7th, so, I'm wondering what's going on there.
