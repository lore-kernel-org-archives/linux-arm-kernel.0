From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 09:51:24 +0200
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 -
 part1
In-Reply-To: <20160915112440.GD6718@leverpostej>
References: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
 <20160915101535.GC3380@arm.com> <20160915112440.GD6718@leverpostej>
Message-ID: <2361858.StHKtxqsL7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 12:24:40 PM CEST Mark Rutland wrote:
> On Thu, Sep 15, 2016 at 11:15:35AM +0100, Will Deacon wrote:
> > From 436d3a7ad25517433fc8f563f44fdab3c4801666 Mon Sep 17 00:00:00 2001
> > From: Will Deacon <will.deacon@arm.com>
> > Date: Thu, 15 Sep 2016 10:14:41 +0100
> > Subject: [PATCH] MAINTAINERS: Update ARM PMU PROFILING AND DEBUGGING entry
> > 
> > There are an increasing number of ARM SoC PMU drivers appearing for
> > things like interconnects, memory controllers and cache controllers.
> > Rather than have these handled on an ad-hoc basis, where SoC maintainers
> > each send their PMU drivers directly to arm-soc, let's take these into
> > drivers/perf/ and send a single pull request to arm-soc instead, much
> > like other subsystems.
> > 
> > This patch amends the ARM PMU MAINTAINERS entry to include all of
> > drivers/perf/ (currently just the ARM CPU PMU), changes Mark Rutland
> > from Reviewer to Maintainer, so that he can help with the new tree and
> > adds the device-tree binding to the list of maintained files.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
