From: davidb@codeaurora.org (David Brown)
Date: Fri, 13 Apr 2012 10:22:01 -0700
Subject: [PATCH] arm: msm: trout: fix compile failure
In-Reply-To: <20120413171619.GA16731@fifo99.com>
References: <1334245537-13395-1-git-send-email-dwalker@fifo99.com>
 <20120413171619.GA16731@fifo99.com>
Message-ID: <20120413172201.GA16754@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 10:16:19AM -0700, Daniel Walker wrote:
> On Thu, Apr 12, 2012 at 08:45:37AM -0700, Daniel Walker wrote:
> > Fixes the following warnings,
> > 
> > arch/arm/mach-msm/board-trout.c: In function 'trout_init':
> > arch/arm/mach-msm/board-trout.c:71: error: 'system_rev' undeclared (first use in this function)
> > arch/arm/mach-msm/board-trout.c:71: error: (Each undeclared identifier is reported only once
> > arch/arm/mach-msm/board-trout.c:71: error: for each function it appears in.)
> > 
> > and
> > 
> > arch/arm/mach-msm/board-trout-panel.c: In function 'trout_init_panel':
> > arch/arm/mach-msm/board-trout-panel.c:267: error: 'system_rev' undeclared (first use in this function)
> > arch/arm/mach-msm/board-trout-panel.c:267: error: (Each undeclared identifier is reported only once
> > arch/arm/mach-msm/board-trout-panel.c:267: error: for each function it appears in.)
> > 
> 
> This needs to go upstream ASAP ..

I was going to send out a pull request today.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
