From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 May 2012 15:40:47 +0000
Subject: [GIT PULL] ux500-core for ARM SoC
In-Reply-To: <CACRpkdY92StLhPv4kpopf8JpU1+PtjrgrdFWdvP4F3fwp1-_Gg@mail.gmail.com>
References: <1335369056-5331-1-git-send-email-linus.walleij@linaro.org>
 <201204302141.08186.arnd@arndb.de>
 <CACRpkdY92StLhPv4kpopf8JpU1+PtjrgrdFWdvP4F3fwp1-_Gg@mail.gmail.com>
Message-ID: <201205021540.48113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012, Linus Walleij wrote:
> 
> On Mon, Apr 30, 2012 at 11:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Please separate this into more logical branches, e.g.
> >
> > 1. delete u5500
> > 2. add u9540 support
> 
> The U9540 stuff was used as a base so when deleting U5500 and
> this code is in close hamming-proximity so you will get
> a lot of conflicts.

Ok, I saw them. I think they are fine, but if they get too annoying,
I will resolve the conflict myself before sending it upstream.

I was mostly worried about the order of stuff, because we are removing
the ixp2xxx socs in the cleanup branch already, which I want to send
early on, so I probably woundn't have complained if you had them in
the opposite order in your branch (removal first, then new stuff) so
I could just have put the last cleanup commit into a branch by itself
and let the other one be based on that.

Anyway, separate pulls are best, so I'm happy now and have applied
pulled your four branches into next/cleanup, next/newsoc, next/dt and
next/cpuidle respectively.

Thanks a lot!

	Arnd
