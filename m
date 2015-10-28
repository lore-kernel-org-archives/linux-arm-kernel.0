From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Oct 2015 15:16:40 +0000
Subject: [PATCH 1/2] arm: perf: Convert event enums to #defines
In-Reply-To: <20151028151352.GD12239@dreric01-gentoo.localdomain>
References: <20151028150758.GA12239@dreric01-gentoo.localdomain>
 <20151028151014.GC12239@dreric01-gentoo.localdomain>
 <20151028151352.GD12239@dreric01-gentoo.localdomain>
Message-ID: <20151028151639.GD18966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 08:13:53AM -0700, Drew Richardson wrote:
> On Wed, Oct 28, 2015 at 08:10:14AM -0700, Drew Richardson wrote:
> > Add additional information about the ARM architected hardware events
> > to make counters self describing. This makes the hardware PMUs easier
> > to use as perf list contains possible events instead of users having
> > to refer to documentation like the ARM TRMs.

[...]

> Sorry, I need to fix my email setup/git. This is 2/2 for the patch,
> not 1/2.

Your first patch also has a second header, so it doesn't apply.

Will
