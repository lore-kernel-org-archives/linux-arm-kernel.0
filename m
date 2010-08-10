From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 23:06:00 +0100
Subject: [GIT PULL] Initial Tegra ARM support
In-Reply-To: <1281476664.9400.36.camel@c-dwalke-linux.qualcomm.com>
References: <AANLkTi=dcQrik=+5xfwbNo_w7WkTOKZiKAFYFhwzbS=_@mail.gmail.com>
	<1281476664.9400.36.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100810220600.GD7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 02:44:24PM -0700, Daniel Walker wrote:
> On Thu, 2010-08-05 at 14:10 -0700, Erik Gilling wrote:
> > Hi Linus,
> > 
> > The following changes since commit 9fe6206f400646a2322096b56c59891d530e8d51:
> >   Linus Torvalds (1):
> >         Linux 2.6.35
> > 
> > are available in the git repository at:
> > 
> >   git://android.kernel.org/kernel/tegra.git for-linus
> > 
> > This code has received review on linux-arm-kernel and has been in
> > for-next since June 18th.  No subsystems were harmed out side of
> > mach-tegra.
> > 
> > Colin Cross (4):
> >       [ARM] tegra: Add clock support
> >       [ARM] tegra: SMP support
> 
> 
> This fixes some typos in the Tegra tree which caused build failures in
> all ARM compiles.

Argh, no, not another patch doing this the wrong way.  I've fixed this
already, just preparing the pull request for this evening.
