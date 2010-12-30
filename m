From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 30 Dec 2010 14:05:58 -0700
Subject: [PATCH v7 00/12] tnetv107x ssp drivers
In-Reply-To: <20101211124242.GE9380@opensource.wolfsonmicro.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
	<87r5dp6tzv.fsf@deeprootsystems.com>
	<20101211124242.GE9380@opensource.wolfsonmicro.com>
Message-ID: <20101230210558.GA3220@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 11, 2010 at 12:42:42PM +0000, Mark Brown wrote:
> On Fri, Dec 10, 2010 at 04:19:48PM -0800, Kevin Hilman wrote:
> 
> > [PATCH v7 08/12] gpio: add ti-ssp gpio driver
> > David Brownell?  (MAINTAINERS isn't clear here)
> 
> It's mostly abandoned at the minute.  Andrew Morton has been taking
> patches.  Grant Likely said he might take it over so sending stuff his
> way might prod him into action.

I probably will pick up GPIO, but not just yet.  I've got to get my dt
and spi house in order first (making good progress here.  I've got an
autotest instance set up so that I can apply and test patches on many
architectures quickly and easily).  Once I've taken care of the backlog
I'll make a decision on whether or not I can pick up gpio too.
Probably sometime mid-January.

g.
