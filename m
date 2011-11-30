From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 30 Nov 2011 14:20:51 +0000
Subject: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
In-Reply-To: <CAHkRjk48jHO19H04rf8252+v04hk9qSdKBrfYCqJsZyamVhMEw@mail.gmail.com>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <201111292129.20444.arnd@arndb.de>
 <alpine.DEB.2.00.1111301053300.31179@kaball-desktop>
 <CAHkRjk48jHO19H04rf8252+v04hk9qSdKBrfYCqJsZyamVhMEw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1111301420000.31179@kaball-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2011, Catalin Marinas wrote:
> On 30 November 2011 11:39, Stefano Stabellini
> <stefano.stabellini@eu.citrix.com> wrote:
> > A git branch is available here (not ready for submission):
> >
> > git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git arm
> >
> > the branch above is based on git://linux-arm.org/linux-2.6.git arm-lpae,
> > even though guests don't really need lpae support to run on Xen.
> 
> Indeed, you don't really need LPAE. What you may need though is
> generic timers support for A15, it would allow less Hypervisor traps.
> For up-to-date architecture patches (well, development tree, not
> guaranteed to be stable), I would recommend this (they get into
> mainline at some point):
> 
> http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=summary
> 
> Either use master or just cherry-pick the branches that you are interested in.

Thanks, I'll rebase on that.
