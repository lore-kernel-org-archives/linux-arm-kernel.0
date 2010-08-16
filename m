From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 16 Aug 2010 11:35:26 +0100
Subject: [PATCH] ARM: perf: reword comments relating to
	perf_event_do_pending
In-Reply-To: <1281954331-5633-1-git-send-email-will.deacon@arm.com>
References: <1281954331-5633-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100816103526.GB2954@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 11:25:31AM +0100, Will Deacon wrote:
> This is purely a cosmetic change to the ARM perf backend because the current
> comments about the relationship between NMIs, interrupt context and
> perf_event_do_pending are misleading.
> 
> This patch updates the comments so that they reflect what the code
> actually does (which is in line with other architectures).
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
Yep, that makes much more sense!

Acked-by: Jamie Iles <jamie.iles@picochip.com>

Jamie
