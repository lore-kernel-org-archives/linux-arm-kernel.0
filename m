From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:47:51 +0000
Subject: [PATCH 08/12] ARM: S3C: Add info for supporting circular DMA
	buffers
In-Reply-To: <20091028123944.GB23925@sirena.org.uk>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
	<1256732153-22027-8-git-send-email-ben-linux@fluff.org>
	<20091028123944.GB23925@sirena.org.uk>
Message-ID: <20091028124749.GD31509@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 12:39:45PM +0000, Mark Brown wrote:
> On Wed, Oct 28, 2009 at 12:15:49PM +0000, Ben Dooks wrote:
> > The S3C64XX DMA implementation will work a lot better with the ability
> > to enqueue circular buffers as the hardware can do it's own linked-list
> > management.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> If Samsung are going to be doing their upstreaming stuff it may make
> sense to merge this via ASoC since I anticipate some changes there, but
> on the other hand that seems to have ground to a halt and the merge may
> well go smoothly anyway.  My standard answer here would be putting the
> patch on a branch by itself so if there are any issues it can be merged
> into both trees to avoid the merge issues.

I was pushing this up via my tree, it touches both the core and ASoC code
so decided to merge myself and copy-you.

On the whole Samsung merging, there is still work in progress there so
we will see what is going to happen.
 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
