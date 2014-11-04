From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 4 Nov 2014 16:49:17 +0100
Subject: [GIT PULL] dts, kbuild: Implement support for dtb vendor subdirs
In-Reply-To: <20141104044717.GA13562@quad.lixom.net>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
 <20141021181504.GV20170@rric.localhost>
 <20141104044717.GA13562@quad.lixom.net>
Message-ID: <20141104154917.GP31556@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.11.14 20:47:17, Olof Johansson wrote:
> > > Robert Richter (6):
> > >   dts, arm64: Add dtbs_install make target
> > >   dts, kbuild: Factor out dtbs install rules to Makefile.dtbinst
> > >   dts, arm/arm64: Remove dtbs build rules in sub-makes
> > >   dts, kbuild: Implement support for dtb vendor subdirs
> > >   dts, arm64: Move dts files to vendor subdirs
> > >   dts, arm: Remove $(MACHINE) variable from dtbs make recipes
> > 
> > please pull this series for inclusion into v3.19 from:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rric/linux.git dts-subdirs-for-arm-soc-v3.19
> > 
> > I have updated and rebased the patches to v3.18-rc1. No changes except
> > conflict resolution of patch 5/6.
> 
> Pulled, and I added the description from 0/6 as the merge text -- feel free to
> add it to the tag if you do something like this in the future.

Thanks for pulling and the hint on the tag description (I was
wondering what to put in there).

-Robert
