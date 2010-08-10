From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 10 Aug 2010 15:10:19 -0700
Subject: [GIT PULL] Initial Tegra ARM support
In-Reply-To: <20100810220600.GD7702@n2100.arm.linux.org.uk>
References: <AANLkTi=dcQrik=+5xfwbNo_w7WkTOKZiKAFYFhwzbS=_@mail.gmail.com>
	<1281476664.9400.36.camel@c-dwalke-linux.qualcomm.com>
	<20100810220600.GD7702@n2100.arm.linux.org.uk>
Message-ID: <1281478219.9400.39.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-10 at 23:06 +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 10, 2010 at 02:44:24PM -0700, Daniel Walker wrote:
> > On Thu, 2010-08-05 at 14:10 -0700, Erik Gilling wrote:
> > > Hi Linus,
> > > 
> > > The following changes since commit 9fe6206f400646a2322096b56c59891d530e8d51:
> > >   Linus Torvalds (1):
> > >         Linux 2.6.35
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://android.kernel.org/kernel/tegra.git for-linus
> > > 
> > > This code has received review on linux-arm-kernel and has been in
> > > for-next since June 18th.  No subsystems were harmed out side of
> > > mach-tegra.
> > > 
> > > Colin Cross (4):
> > >       [ARM] tegra: Add clock support
> > >       [ARM] tegra: SMP support
> > 
> > 
> > This fixes some typos in the Tegra tree which caused build failures in
> > all ARM compiles.
> 
> Argh, no, not another patch doing this the wrong way.  I've fixed this
> already, just preparing the pull request for this evening.

Ok with me, just ask long as it gets fixed soon..

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
