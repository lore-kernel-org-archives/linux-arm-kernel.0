From: davidb@codeaurora.org (David Brown)
Date: Wed, 20 Jul 2011 16:44:21 -0700
Subject: [GIT PULL] MSM fix
In-Reply-To: <20110720225406.GB20310@n2100.arm.linux.org.uk>
References: <20110720203703.GA4495@huya.qualcomm.com>
	<1989166.1WcWHOXyl7@wuerfel>
	<20110720225010.GA18381@huya.qualcomm.com>
	<20110720225406.GB20310@n2100.arm.linux.org.uk>
Message-ID: <20110720234421.GA22665@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 11:54:06PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 20, 2011 at 03:50:10PM -0700, David Brown wrote:
> > On Wed, Jul 20, 2011 at 11:06:15PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 20 July 2011 13:37:03 David Brown wrote:
> > > > I seem to have missed this fix when it was sent out in April.
> > > > 
> > > > The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
> > > > 
> > > >   Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)
> > > > 
> > > > are available in the git repository at:
> > > >   git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix
> > > > 
> > > > Jeff Ohlstein (1):
> > > >       msm: platsmp: actually read core count in get_core_count
> > > > 
> > > 
> > > Hmm, this one seems like it really applies to older kernels as well, so
> > > we can just as well add a cc:stable at kernel.org tag and put it into the
> > > arm-soc/next/fixes branch, right?
> > 
> > It looks like it would apply to 2.6.38 and 39 as well.  I'm not sure
> > it qualifies under the "It must fix a real bug that bothers people".
> > It would only apply if someone had set NR_CPUS to more than 2.
> 
> Err, this makes no sense.  MSM doesn't have a get_core_count function
> and as far as I can see never has done in mainline.
> 
> And where is the patch?
> 
> We shouldn't be pulling git requests into arm-soc without having seen
> the patches on LAKML.

It was sent back in April.

https://patchwork.kernel.org/patch/693881/

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
