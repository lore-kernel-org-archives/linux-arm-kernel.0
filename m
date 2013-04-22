From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 22 Apr 2013 19:02:51 -0400
Subject: [PATCH v8 0/3] of/pci: Provide common support for PCI DT parsing
In-Reply-To: <20130422165343.GE25724@titan.lakedaemon.net>
References: <1366627295-16964-1-git-send-email-Andrew.Murray@arm.com>
 <20130422165343.GE25724@titan.lakedaemon.net>
Message-ID: <20130422230251.GL25724@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:53:43PM -0400, Jason Cooper wrote:
> On Mon, Apr 22, 2013 at 11:41:32AM +0100, Andrew Murray wrote:
> > This patchset factors out duplicated code associated with parsing PCI
> > DT "ranges" properties across the architectures and introduces a
> > "ranges" parser. This parser "of_pci_range_parser" can be used directly
> > by ARM host bridge drivers enabling them to obtain ranges from device
> > trees.
> > 
> > I've included the Reviewed-by, Tested-by and Acked-by's received from v5/v6/v7
> > in this patchset, earlier versions of this patchset (v3) have been tested-by:
> > 
> > Thierry Reding <thierry.reding@avionic-design.de>
> > Jingoo Han <jg1.han@samsung.com>
> > 
> > I've tested that this patchset builds and runs on ARM and that it builds on
> > PowerPC, x86_64 and MIPS.
> 
> Andrew,
> 
> Unfortunately, the mvebu/drivers branch containing your series had to be
> dropped from arm-soc for v3.10.  This was not due to your series, but
> since arm-soc's granularity is branches, your series was caught in the
> drop.
> 
> As the mvebu-pcie driver is now v3.11 material, I have taken the
> opportunity to upgrade from your v7 patchset to v8.  You can find the
> whole branch at mvebu-next/pcie.
> 
> mvebu-next/pcie *will* be rebased onto v3.9 once it drops.  Several
> dependencies will be removed (since they will have been merged into
> v3.9).

s/v3.9/v3.10-rc1/g  :)

> Once the rebase is done, I'll send a pull request to Arnd and Olof so we
> can get as many cycles on -next as possible.

thx,

Jason.
