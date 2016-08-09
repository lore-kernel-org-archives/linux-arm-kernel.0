From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Aug 2016 17:52:16 +0100
Subject: [PATCH] drivers/perf: arm_pmu: fix legacy affinity-less DT support
In-Reply-To: <20160809164839.GN27508@arm.com>
References: <1470757867-13554-1-git-send-email-mark.rutland@arm.com>
 <20160809164839.GN27508@arm.com>
Message-ID: <20160809165216.GO27508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 05:48:39PM +0100, Will Deacon wrote:
> On Tue, Aug 09, 2016 at 04:51:07PM +0100, Mark Rutland wrote:
> For now, I think I'll stick with Marc's patch (that somehow slipped through
> the woodwork), but maybe we should consider removing the SPI/PPI sanity
> checking altogether. At some point we have to rely on the DT being correct,
> and I don't think we do anything disastrout if there is a mismatch in
                                        ^^^^^
Oh dear, mind on other things.

Will
