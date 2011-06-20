From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 21 Jun 2011 01:30:25 +0530
Subject: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
In-Reply-To: <87ei2trbuq.fsf@ti.com>
References: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com>
	<87ei2trbuq.fsf@ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9ACD84@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> 
> A quick test of this series on 3430/n900 shows that it prevents PER
> retention.  I see CM_FCLKEN_PER=0000c000 (debounce clock for GPIO banks
> 3 & 4 are still enabled.)
> 
> Can you retest with debounce enabled on one of the GPIOs for one of your
> platforms?
With one of the module debounce clock enabled it doesn't go to retention.
Later I disabled all modules debounce clock. It doesn't to retention either.
So this is same as your observation. I am surprised what has happened now.
The only thing I could recollect is few patches to solve LDO and
OMAP1 issues while testing before posting. I will investigate further.
--
Tarun
> 
> Kevin
> 
> 
