From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 13 Jan 2015 16:29:30 +0200
Subject: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
In-Reply-To: <20150113115205.GE7660@katana>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
 <20141219104315.0ccbba9c@xhacker> <20150113115205.GE7660@katana>
Message-ID: <20150113142930.GT1386@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 12:52:05PM +0100, Wolfram Sang wrote:
> On Fri, Dec 19, 2014 at 10:43:15AM +0800, Jisheng Zhang wrote:
> > Dear all,
> > 
> > Is there any issue I need to resolve so that the patch can be merged?
> 
> Adding Mika to the loop. He uses the driver a lot (and knows other
> people who do)...

I don't see problems with this patch.

On x86 we have readl_relaxed() the same as readl() so this patch does
not change anything there.

Feel free to add,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
