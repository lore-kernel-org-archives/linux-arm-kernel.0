From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 09:36:09 +0200
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
In-Reply-To: <20130621071239.GM5523@atomide.com>
References: <20130621162656.bb94e0fa8b6813781b804a73@canb.auug.org.au>
 <CAOesGMjszju75jo6Ej6C=0-rfdPLuEj0mwmU1zYvFvYw1dyQCA@mail.gmail.com>
 <20130621071239.GM5523@atomide.com>
Message-ID: <201306210936.09593.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Tony Lindgren wrote:
> > I wonder if this mess is caused by the fact that I did the revert
> > instead of rebuilding our for-next and dropping the merge in the first
> > place.
> > 
> > I'll rebuild our for-next (or maybe Arnd will beat me to it) before
> > next linux-next build, i.e. Sunday night my time.
> 
> Could be, especially if some of the commits are the same in the reverted
> branch and newly merged branch as git might think that some merges have
> been already resolved the right way earlier.

I already rebuilt the arm-soc tree before Stephen started with today's
linux-next, so I think the conflict is elsewhere.

It's probably best if Suman Anna rebases the mailbox tree on top of
the omap mailbox branch that I took.

	Arnd
