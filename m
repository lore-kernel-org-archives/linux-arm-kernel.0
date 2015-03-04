From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 04 Mar 2015 22:09:55 +0100
Subject: [RFC PATCH 00/18] ARM: msm multiplatform support
In-Reply-To: <3942232.3OrEzc0z0v@wuerfel>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <1425501092.2090.21.camel@tiscali.nl> <3942232.3OrEzc0z0v@wuerfel>
Message-ID: <1425503395.2090.31.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added Michal and kbuild.]

Arnd Bergmann schreef op wo 04-03-2015 om 21:35 [+0100]:
> On Wednesday 04 March 2015 21:31:32 Paul Bolle wrote:
> > Arnd Bergmann schreef op wo 04-03-2015 om 20:32 [+0100]:
> > >  arch/arm/mach-msm/board-sapphire.c                 |   17 +-
> > 
> > Please be aware that board-sapphire.c isn't actually wired into the
> > build system _at all_. It never has been (see
> > https://lkml.org/lkml/2014/5/14/634 ). There's another thread were the
> > submitter of this file basically refuses to remove this file, if memory
> > serves me right.
> > 
> > I try not to use colorful language on the net. Perhaps I wouldn't have
> > to bother you now if I would have used such language last year.
> 
> I noticed this, but since it was not standing in the way of what I tried
> to do, I did not do anything about it here.
>  
> > You touch board-sapphire.c in 12/18 and 17/18. That was a waste of your
> > time, however small. Should I submit a separate patch to remove it or do
> > you prefer to fold such a patch into this series?
> 
> The patch would be appreciated, but I'd keep it separate from this series.
> I saw a lot of things in need of cleanup in the files I touched here,
> but refused the temptation, in order to get something done and not
> start something controversial.

I'll resubmit my trivial patch once this series hits linux-next. Feel
free to prod me if I forget.


Paul Bolle
