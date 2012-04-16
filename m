From: dhowells@redhat.com (David Howells)
Date: Mon, 16 Apr 2012 09:35:28 +0100
Subject: [PATCH] arm: msm: trout: fix compile failure
In-Reply-To: <1334245537-13395-1-git-send-email-dwalker@fifo99.com>
References: <1334245537-13395-1-git-send-email-dwalker@fifo99.com>
Message-ID: <8793.1334565328@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Walker <dwalker@fifo99.com> wrote:

> Fixes the following warnings,
> 
> arch/arm/mach-msm/board-trout.c: In function 'trout_init':
> arch/arm/mach-msm/board-trout.c:71: error: 'system_rev' undeclared (first use in this function)
> arch/arm/mach-msm/board-trout.c:71: error: (Each undeclared identifier is reported only once
> arch/arm/mach-msm/board-trout.c:71: error: for each function it appears in.)
> 
> and
> 
> arch/arm/mach-msm/board-trout-panel.c: In function 'trout_init_panel':
> arch/arm/mach-msm/board-trout-panel.c:267: error: 'system_rev' undeclared (first use in this function)
> arch/arm/mach-msm/board-trout-panel.c:267: error: (Each undeclared identifier is reported only once
> arch/arm/mach-msm/board-trout-panel.c:267: error: for each function it appears in.)
> 
> This came in with the following commit 9f97da78bf018206fb623cd351d454af2f105fe0
> which removes asm/system.h
> 
> Signed-off-by: Daniel Walker <dwalker@fifo99.com>
> cc: David Howells <dhowells@redhat.com>
> cc: Bryan Huntsman <bryanh@codeaurora.org>
> cc: linux-arm-msm at vger.kernel.org
> cc: linux-arm-kernel at lists.infradead.org

Acked-by: David Howells <dhowells@redhat.com>
