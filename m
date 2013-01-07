From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 6 Jan 2013 20:31:52 -0800
Subject: [slave-dma:next 10/44]
 arch/arm/mach-spear13xx/spear1310.c:50:2: error: 'DMAC0_BASE' undeclared
 here (not in a function)
In-Reply-To: <CAKohpo=Z2Y1Vo3T4x3y__Xp_dKETtO-MCQDHhRYNwJ5-YztgVw@mail.gmail.com>
References: <50e9c0da.1vFAsky7xkvAf1HF%fengguang.wu@intel.com>
 <CAKohpo=Z2Y1Vo3T4x3y__Xp_dKETtO-MCQDHhRYNwJ5-YztgVw@mail.gmail.com>
Message-ID: <20130107043152.GA2140@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 10:09:53AM +0530, Viresh Kumar wrote:
> Hi Vinod,
> 
> On 6 January 2013 23:52, kbuild test robot <fengguang.wu@intel.com> wrote:
> > tree:   git://git.infradead.org/users/vkoul/slave-dma.git next
> > head:   3c1eea5112859d9467a27d4f6671cb3162481420
> > commit: 9a1e6fbf2b084ff903d33671b3f7fb09cd633f78 [10/44] ARM: SPEAr13xx: Pass DW DMAC platform data from DT
> > config: make ARCH=arm spear13xx_defconfig
> >
> > All error/warnings:
> >
> > FATAL ERROR: Unable to parse input tree
> > --
> > arch/arm/mach-spear13xx/spear1310.c:50:2: error: 'DMAC0_BASE' undeclared here (not in a function)
> > arch/arm/mach-spear13xx/spear1310.c:51:2: error: 'DMAC1_BASE' undeclared here (not in a function)
> 
> There were multiple issues with the latest rebase done on 3.8-rc2.
> Over that there is an issue in
> this patch, due to which merge with ARM-SoC tree was broken... I have
> fixed rebase
> and merge issues in below patch. Please pick it up:
> 
> (ARM mail servers are facing some issues now a days and so patch would
> be broken,
> hence attaching it too)
Thanks for this. Yes rebase seems to have caused many issues so I am redoing it
right now. Will let you know once the tree is updated

--
~Vinod
