From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 13 Jun 2014 22:38:56 +0200 (CEST)
Subject: [PATCH V2 00/19] irqchip: crossbar: driver fixes
In-Reply-To: <20140613165458.GS8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <20140613150122.GP8664@titan.lakedaemon.net>
 <1402676074.12385.40.camel@joe-AO725>
 <20140613163714.GR8664@titan.lakedaemon.net>
 <1402678104.3509.1.camel@joe-AO725>
 <20140613165458.GS8664@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.10.1406132222570.5170@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jun 2014, Jason Cooper wrote:
> On Fri, Jun 13, 2014 at 09:48:24AM -0700, Joe Perches wrote:
> > On Fri, 2014-06-13 at 12:37 -0400, Jason Cooper wrote:
> > > On Fri, Jun 13, 2014 at 09:14:34AM -0700, Joe Perches wrote:
> > > > On Fri, 2014-06-13 at 11:01 -0400, Jason Cooper wrote:
> > > > > Please format the subject lines like so:
> > > > > 
> > > > >   irqchip: crossbar: Set cb pointer ...
> > > > >                      ^
> > > > >                      |
> > > > >                      \-- note the capitalization
> > > > 
> > > > I suggest you don't make this a rule and focus
> > > > on more important stuff instead.

Says the one, who pesters people about typos in changelogs....

WTF? Jason is doing a great job in reviewing and he knows what to
concentrate on.

> > > It's not my rule.  ;-)
> > 
> > Who's rule is it then?
> 
> Thomas'

Sentences start with an upper case letter. Our brain is trained on
that rule when parsing a line.

So for people who actually review patches by reading them instead of
running a spell checker, consistent formatting more important than
avoiding the random typo, which our brain just blends out in most of
the cases. Unfortunately also when the typo is in actual code :(

Thanks,

	tglx






   

   
