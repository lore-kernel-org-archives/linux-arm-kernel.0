From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Sep 2013 09:16:11 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
Message-ID: <20130909001611.GE21921@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 06:21:23PM +0200, Linus Walleij wrote:
> On Wed, Sep 4, 2013 at 5:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> (...)
> >  arch/arm/mach-shmobile/clock-r8a7791.c        |  198 +++++++++++++++++++++++++
> 
> So what about starting afresh by letting this new SoC use the
> generic clk framework in drivers/clk from day one instead of
> adding another chunk of custom clk code to the kernel?
> 
> (There may be reasons for this, but I have to ask the
> inevitable question.)

Perhaps I was a bit hasty, but I have already queued up these changes.
And moreover I believe they are useful in their current form for
back-porting to LTSI-3.4, which I have also already done.

So on those two counts my preference would be for any enhancements
to be done as incremental patches on top of this series.
