From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Mar 2014 22:54:49 -0800
Subject: [GIT PULL] Integrator multiplatform patches, take two
In-Reply-To: <CACRpkdbWNNcQCa0XLHo_CPOcjBNAPORhaZ9+ct1QWaLJjFoxMg@mail.gmail.com>
References: <CACRpkdbWNNcQCa0XLHo_CPOcjBNAPORhaZ9+ct1QWaLJjFoxMg@mail.gmail.com>
Message-ID: <20140309065449.GD16310@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 02:04:39PM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is anoter package of multiplatform patches for v3.15, clearing the
> view with the final objective in clear sight.
> 
> I have tested to pull this cleanly on top of your
> integrator/multiplatform-base branch, so it can be pulled on top
> of that.
> 
> Two things remain to be solved after this:
> 
> - Handle the CLCD display database and/or convert this to use the
>   device tree somehow.
> 
> - Handle the <mach/memory.h> bus offset stuff assumed to be there for
>   PCI DMA in an elegant way.
> 
> So these have to be hashed out next.
> 
> After that we can go full multiplatform for the Integrator, clearing the way
> for Versatile and RealView as well.
> 
> Please pull this in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 29525484cd2524a31ee0924831ab43b46ea6ebe1:
> 
>   ARM: integrator: select GPIO block (2014-02-13 11:21:37 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-for-v3.15-2
> 
> for you to fetch changes up to a79528e9d849803457b6235ddb1a1cfd4e11c6cd:
> 
>   ARM: integrator: register sched_clock directly (2014-02-26 13:49:07 +0100)

Thanks, merged. This one was a little hard to find a home for since it depends
on the previous driver rework. I created a next/cleanup2 for this, if we don't
get more suitable material for that branch we'll fold it into something else
later.


-Olof
