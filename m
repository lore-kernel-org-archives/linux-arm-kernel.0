From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 17:18:28 -0700
Subject: [PATCH v4 08/17] ocksource: dbx500-prcmu: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-9-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130719001828.GE27430@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18, Stephen Boyd wrote:
> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.
> 
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Hmph, the subject got messed up. If I don't resend please correct
to clocksource.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
