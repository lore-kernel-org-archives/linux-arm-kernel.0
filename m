From: dwalker@fifo99.com (Daniel Walker)
Date: Fri, 13 Apr 2012 10:16:19 -0700
Subject: [PATCH] arm: msm: trout: fix compile failure
In-Reply-To: <1334245537-13395-1-git-send-email-dwalker@fifo99.com>
References: <1334245537-13395-1-git-send-email-dwalker@fifo99.com>
Message-ID: <20120413171619.GA16731@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 08:45:37AM -0700, Daniel Walker wrote:
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

This needs to go upstream ASAP ..

Daniel
