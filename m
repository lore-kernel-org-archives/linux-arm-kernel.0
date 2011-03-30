From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Mar 2011 10:12:30 +0100
Subject: [PATCH] arm: fix build failure introduced by typo in irq
	namespace cleanup.
In-Reply-To: <alpine.LFD.2.00.1103301107020.22418@localhost6.localdomain6>
References: <20110330060229.27397.7628.stgit@ponder>
	<alpine.LFD.2.00.1103301107020.22418@localhost6.localdomain6>
Message-ID: <20110330091230.GB29121@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 11:08:07AM +0200, Thomas Gleixner wrote:
> On Wed, 30 Mar 2011, Grant Likely wrote:
> 
> > Commit 6845664a6a7d443f03883db59d10749d38d98b8e, "arm: Cleanup the irq
> > namespace" introduces a typo causing a build failure for the versatile
> > platform.
> 
> Sorry about that. I have no clue how I fatfingered that in last
> minute.
> 
> rmk: are you picking it up or should I push it linuswards with the
> other fixups ?

If you have other fixes which you're already sending, you might as well
include those.  Linus hasn't pulled my stuff from last night so I'm not
touching my tree today.
