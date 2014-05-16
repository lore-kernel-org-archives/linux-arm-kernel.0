From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 16:03:33 +0900
Subject: [PATCH v6 00/12] CCF support for Renesas r7s72100
In-Reply-To: <20140516064938.GA2593@katana>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
 <20140514050801.GE3502@verge.net.au>
 <CAMuHMdUTQbTSU4GSuxZX22QTqyQuo-zsNg4+d+OqpqEbjOnCaA@mail.gmail.com>
 <20140514230241.GA29233@verge.net.au>
 <20140516001944.GA9418@verge.net.au> <20140516064938.GA2593@katana>
Message-ID: <20140516070333.GA9149@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 08:49:38AM +0200, Wolfram Sang wrote:
> > > I do not feel particularly strongly about this.  But it seems to me that it
> > > would make sense to take the same approach as koelsch and lager.
> > 
> > Wolfram, are you planing to handle this one way or another?
> 
> I'll check what it takes for the reference removal. Hopefully it is not
> too late in the cycle for this?

It is my hope that such a change can be treated as a fix and thus it is not
too late.

I suspect that if you look at the reference removal of koelsch and lager,
or the more recent marzen patches, that you should be able to see a pattern
that works for genmai too.
