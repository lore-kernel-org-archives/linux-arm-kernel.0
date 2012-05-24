From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 24 May 2012 09:07:38 +0200
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <201205231939.49681.arnd@arndb.de>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231743.50262.arnd@arndb.de>
 <87396qbtrx.fsf@lebrac.rtp-net.org>
 <201205231939.49681.arnd@arndb.de>
Message-ID: <20120524070737.GC2180@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 07:39:49PM +0000, Arnd Bergmann wrote:
> 
> Ok, thanks for the info. I'm sorry that it has come so far. I think Olof
> and I are generally doing a good job at picking up all the pull requests,
> but we sometimes miss single patches, especially when it's not clear that
> they are expected to go into the arm-soc tree.
> 
> I have to admit that I didn't even remember who maintains ixp4xx, since
> there hasn't been a single ixp4xx patch from Imre or Krzysztof that I've put
> into the kernel over this time frame.

It seems like the maintainers are not very responsive.

> What is the plan for ixp4xx going forward? Is one of you planning to
> maintain a git tree and collect patches for inclusion in arm-soc?
> I would be more comfortable just knowing where to pull from than
> having to watch the mailing list and making sure the maintainers
> Ack all the patches.
> If there is no tree, should we downgrade ixp4xx in the MAINTAINERS
> file from "Maintained" to "Odd fixes"?

Yes, there should be some kind of plan.

Thanks,
Richard
