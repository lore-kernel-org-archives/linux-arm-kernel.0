From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 19:03:23 +0100
Subject: genirq: Generic irq chip available in git
In-Reply-To: <20110511175837.GA21150@opensource.wolfsonmicro.com>
References: <alpine.LFD.2.02.1104231805321.3323@ionos>
	<20110427212542.GD17290@n2100.arm.linux.org.uk>
	<20110508082222.GA27807@n2100.arm.linux.org.uk>
	<20110508133530.GA13815@opensource.wolfsonmicro.com>
	<20110508140023.GK27807@n2100.arm.linux.org.uk>
	<20110508140344.GC15968@opensource.wolfsonmicro.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CE66709@dbde02.ent.ti.com>
	<20110511175522.GI5315@n2100.arm.linux.org.uk>
	<20110511175837.GA21150@opensource.wolfsonmicro.com>
Message-ID: <20110511180323.GJ5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 07:58:37PM +0200, Mark Brown wrote:
> On Wed, May 11, 2011 at 06:55:22PM +0100, Russell King - ARM Linux wrote:
> > On Wed, May 11, 2011 at 11:15:57PM +0530, Nori, Sekhar wrote:
> 
> > > I have included Thomas's davinci platform update with the relevant
> > > acks in the following pull request. There was also a checkpatch
> > > error that I fixed up locally. Hope this helps.
> 
> > Thanks, pulled this.
> 
> FWIW I sent a similar pull request to Kukjin a few days ago for Samsung:

I've not noticed it turning up in linux-next - in fact the linux-next stats
still looks poorly in respect of what I'd expect it to be given the amount
of stuff discussed since the last merge window.  So...

> The following changes since commit cfefd21e693dca791bf9ecfc9dd3794facad533c:
> 
>   genirq: Add chip suspend and resume callbacks (2011-04-23 15:56:24 +0200)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc-2.6.git samsung-irq

I've pulled this too in an attempt to improve the stats.  It doesn't
matter whether or not Kukjin has pulled this too.
