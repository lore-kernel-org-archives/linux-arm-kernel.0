From: will.deacon@arm.com (Will Deacon)
Date: Mon, 07 Mar 2011 10:19:15 +0000
Subject: [PATCH 2/3] [ARM] perfevents: Add support for Scorpion
	performance monitors
In-Reply-To: <1299276616-12918-1-git-send-email-sheetals@codeaurora.org>
References: <1299276616-12918-1-git-send-email-sheetals@codeaurora.org>
Message-ID: <1299493155.7349.2.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sheetal,

On Fri, 2011-03-04 at 22:10 +0000, Sheetal Sahasrabudhe wrote:
> This commit adds support for performance monitors provided by
> Qualcomm Scorpion and ScorpionMP processor to perfevents.
> 
> Signed-off-by: Sheetal Sahasrabudhe <sheetals@codeaurora.org>
> ---
>  arch/arm/include/asm/perf_event.h |    2 +
>  arch/arm/kernel/perf_event.c      |   11 +
>  arch/arm/kernel/perf_event_qc.c   |  677 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 690 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_event_qc.c

I reviewed a few iterations of this patch off-list so you can add my
review tag (after fixing the comments and filename as pointed out by
Bryan):

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
