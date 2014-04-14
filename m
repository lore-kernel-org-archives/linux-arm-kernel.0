From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Apr 2014 17:59:56 +0100
Subject: [PATCH 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
In-Reply-To: <20140407121304.GD3360@arm.com>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140403160727.17b3558b@skate>
 <20140403141533.GP7528@n2100.arm.linux.org.uk>
 <20140407121304.GD3360@arm.com>
Message-ID: <20140414165956.GJ12916@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 01:13:04PM +0100, Catalin Marinas wrote:
> On Thu, Apr 03, 2014 at 03:15:33PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 03, 2014 at 04:07:27PM +0200, Thomas Petazzoni wrote:
> > > Any comments about the proposed patches? These are important for the
> > > recent Armada 375/38x platforms and I'm sure will require a bit of
> > > discussion. Moreover, one of the patch affects the L2 cache driver that
> > > Russell is currently working on, so it would be nice if we could get
> > > the discussion going soon.
> > 
> > Will is away for another week and a half.
> 
> And when he's back, I'm pretty sure he will be eager to look at the
> PL310 code ;)

Lucky for me, it looks like rmk is rewriting it ;)

Is there anything you want me to do here?

Will
