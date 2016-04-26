From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 12:26:23 +0200
Subject: [GIT PULL v2 1/2] ARM: vexpress: addition of MPS2 platform
 support for v4.7
In-Reply-To: <571F406E.9010503@arm.com>
References: <1461601876-25288-1-git-send-email-sudeep.holla@arm.com>
 <7512668.6FnnShhbHF@wuerfel> <571F406E.9010503@arm.com>
Message-ID: <6374181.eVf0heegjj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 11:18:22 Sudeep Holla wrote:
> 
> Thanks for having a look at this.
> 
> > However, the way we pull them in, I need them separately for dts, defconfig and
> > the rest. This means only one or two patches for each branch, which is getting
> > slightly silly at that point, so you could just send them as patches,
> > or I can cherry-pick the changes into the individual branches to save you
> > yet another respin.
> 
> Sure, I have pushed 3 branches accordingly:
> 1. for-next/mps2
> 2. for-next/mps2-dt
> 3. for-next/mps2-defconfig
> 
> @ git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> 
> Let me know if that's fine for you. I can tag and send PR if needed.

The split is fine, and as I said before, I could also just cherry-pick
the individual patches from it, but if you want me to pull the branches
please add the signed tags.

	Arnd
