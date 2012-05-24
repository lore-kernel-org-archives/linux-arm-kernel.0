From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 May 2012 09:01:56 +0000
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <20120524070737.GC2180@netboy.at.omicron.at>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231939.49681.arnd@arndb.de>
 <20120524070737.GC2180@netboy.at.omicron.at>
Message-ID: <201205240901.56570.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 May 2012, Richard Cochran wrote:
> On Wed, May 23, 2012 at 07:39:49PM +0000, Arnd Bergmann wrote:
> > 
> > Ok, thanks for the info. I'm sorry that it has come so far. I think Olof
> > and I are generally doing a good job at picking up all the pull requests,
> > but we sometimes miss single patches, especially when it's not clear that
> > they are expected to go into the arm-soc tree.
> > 
> > I have to admit that I didn't even remember who maintains ixp4xx, since
> > there hasn't been a single ixp4xx patch from Imre or Krzysztof that I've put
> > into the kernel over this time frame.
> 
> It seems like the maintainers are not very responsive.
> 
> > What is the plan for ixp4xx going forward? Is one of you planning to
> > maintain a git tree and collect patches for inclusion in arm-soc?
> > I would be more comfortable just knowing where to pull from than
> > having to watch the mailing list and making sure the maintainers
> > Ack all the patches.
> > If there is no tree, should we downgrade ixp4xx in the MAINTAINERS
> > file from "Maintained" to "Odd fixes"?
> 
> Yes, there should be some kind of plan.

So would you be available to help out as a maintainer if Imre and
Krzysztof are no longer interested? You seem to be the only person
who has pushed any non-janitorial patches over the last year here.
I don't think it would be much work, mostly collecting the odd fixes
and occasionally trying that the boards you have still boot.

	Arnd
