From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 12 Jun 2013 14:51:34 -0400
Subject: [PATCHv3 3/3] arm64: Move to generic sched_clock infrastructure
In-Reply-To: <1370476485-468-4-git-send-email-sboyd@codeaurora.org>
References: <1370476485-468-1-git-send-email-sboyd@codeaurora.org>
 <1370476485-468-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <51B8C336.4050700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 07:54 PM, Stephen Boyd wrote:
> Use the generic sched_clock infrastructure instead of rolling our
> own. This has the added benefit of fixing suspend/resume as
> outlined in 6a4dae5 (ARM: 7565/1: sched: stop sched_clock()
> during suspend, 2012-10-23) and correcting the timestamps when
> the hardware returns a value instead of 0 upon the first read.

Builds and runs for me on software models.

Tested-by: Christopher Covington <cov@codeaurora.org>

Cheers,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
