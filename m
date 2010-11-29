From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Nov 2010 22:11:15 +0000
Subject: [GIT PULL] Kconfig changes for MSM to enable SMP
In-Reply-To: <1291065170.30902.22.camel@c-dwalke-linux.qualcomm.com>
References: <1290531015.4165.19.camel@m0nster>
	<1291065170.30902.22.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20101129221115.GC20761@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 01:12:50PM -0800, Daniel Walker wrote:
> On Tue, 2010-11-23 at 08:50 -0800, Daniel Walker wrote:
> > Russell,
> > 
> > I've been trying to get these in for a while now. They're just Kconfig
> > changes that allow MSM to use SMP. One of the patch does have a slight
> > clean up where it moves the "\" out one space under "config SMP". I
> > think that was the product of some feedback I received.
> > 
> > Please pull, or let me know if you want them done differently.
> 
> Could you give me some feedback on why your not pulling this? I need
> these changes to go in in order to add SMP support, which I have planned
> to add this coming merge window.
> 
> Do you want these going into you patch system? Do you not like the lack
> of TWD and SCU support or the way I accomplished the removal of them?
> 
> Gimme some hints please ..

commit 612275ad3966dd7ba491d5fe94e894a3861c9062
Merge: 698fd6a2 176bfc4
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Nov 26 10:26:10 2010 +0000

    Merge branch 'for-russell' of git://codeaurora.org/quic/kernel/dwalker/linux-msm into devel-stable


?
