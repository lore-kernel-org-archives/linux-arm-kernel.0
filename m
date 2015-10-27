From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Oct 2015 17:32:38 +0000
Subject: [PATCHv2] arm: perf: Add event descriptions
In-Reply-To: <20151022140557.GA2154@dreric01-gentoo.localdomain>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
 <20151022140557.GA2154@dreric01-gentoo.localdomain>
Message-ID: <20151027173238.GE22049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 07:05:58AM -0700, Drew Richardson wrote:
> On Fri, Oct 09, 2015 at 03:13:38AM -0700, Will Deacon wrote:
> > Also, would you be able to do something similar for AArch64 too, please?
> > (take a look at our for-next/core branch for the latest perf changes).
> 
> Here are some almost identical patches for AArch64 based on arm64
> tree's for-next/core branch. Please note that this is dependent on
> some change to drivers/perf/arm_pmu.c so that pmu.attr_groups is
> preserved.

Has a revised version of that prerequisite patch been posted anywhere? I
can't seem to find it in my inbox...

Will
