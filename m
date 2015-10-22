From: drew.richardson@arm.com (Drew Richardson)
Date: Thu, 22 Oct 2015 07:05:58 -0700
Subject: [PATCHv2] arm: perf: Add event descriptions
In-Reply-To: <20151009101338.GH26278@arm.com>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
Message-ID: <20151022140557.GA2154@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 03:13:38AM -0700, Will Deacon wrote:
> Also, would you be able to do something similar for AArch64 too, please?
> (take a look at our for-next/core branch for the latest perf changes).

Here are some almost identical patches for AArch64 based on arm64
tree's for-next/core branch. Please note that this is dependent on
some change to drivers/perf/arm_pmu.c so that pmu.attr_groups is
preserved.

Drew
