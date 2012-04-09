From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Apr 2012 14:09:04 +0000
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <20120406234313.A040E3E127F@localhost>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <201203280820.00139.arnd@arndb.de> <20120406234313.A040E3E127F@localhost>
Message-ID: <201204091409.04927.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 April 2012, Grant Likely wrote:
> On Wed, 28 Mar 2012 08:19:59 +0000, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 27 March 2012, Jamie Lentin wrote:
> > > Add support for the DNS-320 and DNS-325. Describe as much as currently possible
> > > in the devicetree files, create a board-dnskw.c for everything else.
> > > 
> > > Use IEEE-compliant "okay", rather than "ok"
> > > 
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > > Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> > > ---
> > 
> > One small note about changeset comments: The part about differences from the previous
> > version of the same patch normally goes below the '---' line, in front of the diffstat,
> > to prevent it from going into the git changelog. Otherwise people will have no idea
> > what it's about.
> 
> Counter point on that.  I ask submitters to put the changelog before
> the --- because I want it in the commit text.  It is actually helpful
> when trying to determine exactly which iteration of a patch series got
> committed.

Fair enough, but I think in this case it was written in a confusing way. I don't
mind if a list of review comments are included and more text is usally better
in the changeset comment, but it would be nice to give some background, either
by prefixing it with something "Addressed review comments from xxx:" or changing
it to 'This version uses the IEEE-compliant "okay", rather than "ok"'.

	Arnd
