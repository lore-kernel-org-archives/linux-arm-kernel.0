From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 19:20:43 +0100
Subject: [PATCH 1/2] ARM: mvebu: second PCIe unit of Armada XP mv78230
 is only x1 capable
In-Reply-To: <20131106181241.GG8308@titan.lakedaemon.net>
References: <cover.1383681717.git.arno@natisbad.org>
 <b5f36f547bb12ed4e5398401685523625ca50312.1383681717.git.arno@natisbad.org>
 <20131106154326.27a4cc27@skate> <877gclcsjf.fsf@natisbad.org>
 <20131106181241.GG8308@titan.lakedaemon.net>
Message-ID: <20131106192043.3f2d9ca0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 6 Nov 2013 13:12:41 -0500, Jason Cooper wrote:

> > > However, while the PCIe DT stuff was merged in 3.10, the actual driver
> > > itself was only merged in 3.11, so in 3.10, there is no chance to hit
> > > the bug.
> > >
> > > Therefore, having this fix pushed to the stable 3.11.x and 3.12.x trees
> > > would be good.
> 
> oops, I forgot to reply to this.  I disagree here.  We shouldn't assume
> that the dts file used will be from the same commit and the kernel
> built.  Additionally, it doesn't hurt to backport the change the whole
> way.

Well, I believe anyone trying to use mvebu .dts from one kernel version
with a kernel image of another version will hit numerous problems. But
ok, in principle I agree with you :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
