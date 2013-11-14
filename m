From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 14 Nov 2013 15:05:40 -0800
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131114230436.GV9468@ld-irv-0074.broadcom.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131114230436.GV9468@ld-irv-0074.broadcom.com>
Message-ID: <20131114230540.GW9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Daniel (missed the CC)

On Thu, Nov 14, 2013 at 03:04:36PM -0800, Brian Norris wrote:
> On Thu, Nov 14, 2013 at 06:25:25PM -0300, Ezequiel Garcia wrote:
> > * Changes from v4
> > 
> >   * Rebased on top of l2-mtd.git origin/next branch
> > 
> >   * Fixed is_ready flag reset, renamed by a more descriptive
> >     and readble "need_wait".
> > 
> 
> ...
> 
> I think this series is now good as-is. Pushing to l2-mtd.git/next.
> Thanks for the efforts! I can submit my extra diff from patch 12 as a
> separate patch for review.
> 
> Do you have any available regression tests? Or was there somebody else
> we could run this by for some Tested-by's? Daniel Mack, perhaps?

Brian
