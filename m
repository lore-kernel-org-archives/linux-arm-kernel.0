From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Jan 2011 11:09:36 +0900
Subject: [PATCH] rfc v3: ARM: mach-shmobile: mackerel: Add zboot support
In-Reply-To: <20110107013725.GB22477@linux-sh.org>
References: <1291855635-30882-1-git-send-email-horms@verge.net.au>
	<20110107013725.GB22477@linux-sh.org>
Message-ID: <20110107020935.GA9221@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 10:37:25AM +0900, Paul Mundt wrote:
> On Thu, Dec 09, 2010 at 09:47:15AM +0900, Simon Horman wrote:
> > When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
> > boot loader and may be burned to rom or flash.
> > 
> > Compile tested only.
> > 
> > This patch assumes that head-mackerel.txt will be the same as head-ap4evb.txt.
> > I am waiting for verification of this.
> > 
> > This patch depends on
> > * ARM: 6515/1: Add zboot support for SuperH Mobile ARM
> >   (merged into the devel branch of Russel King's linux-2.6-arm tree)
> > * ARM: 6514/1: mach-shmobile: Add zboot support for SuperH Mobile ARM
> >   (merged into the devel branch of Russel King's linux-2.6-arm tree)
> > * MACH_MACKEREL (3211) being present in arch/arm/tools/mach-types
> > 
> Ok, I've applied this one now that the dependencies are out of the way.
> 
> I plan to send my rmobile updates to Linus today, at which point you
> should be able to submit the outstanding MMCIF patch to Russell's patch
> tracker.

Thanks
