From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 Apr 2015 09:21:36 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a73a4 CCF and Multiplatform
 Updates for v4.1
In-Reply-To: <20150401233211.GB8137@localhost>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
 <20150401233211.GB8137@localhost>
Message-ID: <20150402002136.GC16176@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 04:32:11PM -0700, Olof Johansson wrote:
> On Thu, Mar 05, 2015 at 10:57:57AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC r8a73a4 CCF and multiplatform
> > updates for v4.1.
> > 
> > 
> > This pull request is based on "Renesas ARM Based SoC Simple PM Bus Updates
> > for v4.1", tagged as renesas-simple-pm-bus-for-v4.1, which you have already
> > pulled. That pull request provides run-time dependencies for this one.
> > 
> > 
> > This pull requests has minor conflicts with "Renesas ARM Based SoC sh7372
> > SoC Removal Updates for v4.1", tagged as
> > renesas-sh7372-soc-removal-for-v4.1, which you have already pulled.
> > 
> > The conflicts are in the following files:
> > 	arch/arm/mach-shmobile/Kconfig
> > 	arch/arm/mach-shmobile/Makefile
> > 
> > The solution is to delete both.
> > 
> > This solution can be found in the renesas-next-20150305v2-v4.0-rc1 tag of
> > the renesas tree.
> > 
> > 
> > The following changes since commit 89d463ea106dba530786a2815fd174f9e6eab71f:
> > 
> >   drivers: bus: Add Simple Power-Managed Bus Driver (2015-02-24 06:36:18 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a73a4-ccf-and-multiplatform-for-v4.1
> > 
> > for you to fetch changes up to 914d7d148411997c2f76f689338d27c362300b7a:
> > 
> >   ARM: shmobile: r8a73a4: Remove legacy code (2015-02-25 16:14:02 +0900)
> 
> Thanks, merged.
> 
> I don't see a reason for you to split your branches per SoC like this
> though -- you already had another multiplatform branch for another SoC,
> you can combine the two.

I think that the reason was that historically I had only done
multiplatform for one SoC at a time and thus had become used to
per-SoC multiplatform branches.
