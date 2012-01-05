From: hjk@hansjkoch.de (Hans J. Koch)
Date: Thu, 5 Jan 2012 13:49:05 +0100
Subject: [GIT PULL] Remove Telechips ARM subarch
In-Reply-To: <20120105104926.GN11810@n2100.arm.linux.org.uk>
References: <20111222211948.GA1201@local> <20111222212240.GB1201@local>
 <20120103170824.GA2914@n2100.arm.linux.org.uk>
 <20120104030052.GC2518@local>
 <20120105104926.GN11810@n2100.arm.linux.org.uk>
Message-ID: <20120105124905.GA6616@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 10:49:26AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 04, 2012 at 04:00:53AM +0100, Hans J. Koch wrote:
> > On Tue, Jan 03, 2012 at 05:08:24PM +0000, Russell King - ARM Linux wrote:
> > > On Thu, Dec 22, 2011 at 10:22:40PM +0100, Hans J. Koch wrote:
> > > > 
> > > > The AMR subarchitecture for Telechips SoCs is completely removed,
> > > 
> > > Apart from this spelling mistake, the rest look fine.  Do you want to
> > > send me a pull request with that fixed?
> > 
> > OK, typo fixed.
> > 
> > The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:
> > 
> >   Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)
> > 
> > are available in the git repository at:
> >   git://hansjkoch.de/git/linux-tcc for-russell
> 
> Well, it looks like an include or two was missed in arch/arm/Kconfig:
> 
> scripts/kconfig/conf --silentoldconfig Kconfig
> arch/arm/Kconfig:1066: can't open file "arch/arm/plat-tcc/Kconfig"

Grrmpf, yes. Sorry.

> 
> Could you quickly fix that and I'll re-pull it?

OK, fixed. Please pull again.

Thanks,
Hans
