From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Jun 2015 00:04:02 -0700
Subject: next-20150604 build: 2 failures 37 warnings (next-20150604)
In-Reply-To: <20150608205632.GB11211@kroah.com>
References: <E1Z0YIL-0008Ma-5O@optimist> <20150604170112.GM14071@sirena.org.uk>
 <20150604171004.GZ30984@atomide.com>
 <20150604172026.GA30984@atomide.com>
 <20150605104900.GA5346@kroah.com>
 <20150605171652.GB14071@sirena.org.uk>
 <20150608205632.GB11211@kroah.com>
Message-ID: <20150610070402.GB2740@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [150608 13:58]:
> On Fri, Jun 05, 2015 at 06:16:52PM +0100, Mark Brown wrote:
> > On Fri, Jun 05, 2015 at 07:49:00PM +0900, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 04, 2015 at 10:20:26AM -0700, Tony Lindgren wrote:
> > 
> > > > Greg, there's now commit 9809889c708e in tty-linus and commit
> > > > 9e91597f2423 in tty-next.
> > 
> > > Yes, I can't go back and remove the one in tty-next, I'm guessing when
> > > they are merged there is an issue.  I'll look into that after Linus
> > > pulls in my tty-linus tree.
> > 
> > Yeah, git isn't always spectacularly good at resolving add/add if
> > there's context changes between two things in a merge - it sometimes
> > ends up double adding things.
> 
> Ok, I've now merged these branches together, if someone can verify that
> my tty-next branch is correct, that would be great.

I've verified that things are working for 8250_omap thanks.

Tony
