From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 27 Jul 2011 23:34:24 -0700
Subject: [RFC PATCH v9 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>
References: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4E3102F0.4030705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2011 09:57 AM, Marc Zyngier wrote:
> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> problems:
>
[snip]
>
> Patches against next-20110721, tested on PB11MP. As this patch series
> is quite different from the previous one, I've dropped all previous
> acks from platform maintainers.

I tried this out the other day and it didn't work. The setup_irq() calls
in msm timer code fails and then we calibrate delay forever. I haven't
looked further.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
