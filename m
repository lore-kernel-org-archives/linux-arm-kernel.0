From: davidb@codeaurora.org (David Brown)
Date: Thu, 1 Aug 2013 09:12:55 -0700
Subject: [PATCH 08/18] ARM: msm: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-9-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
 <1375309877-16617-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130801161255.GA17642@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 03:31:07PM -0700, Stephen Boyd wrote:
>The 32 bit sched_clock interface now supports 64 bits. Upgrade to
>the 64 bit function to allow us to remove the 32 bit registration
>interface.
>
>Cc: David Brown <davidb@codeaurora.org>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> arch/arm/mach-msm/timer.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
