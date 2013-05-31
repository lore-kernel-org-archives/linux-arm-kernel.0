From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 May 2013 11:38:28 -0700
Subject: [PATCHv6 07/11] ARM: PRIMA2: Divorce timer-marco from local
 timer API
In-Reply-To: <1368473175-4841-8-git-send-email-sboyd@codeaurora.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
 <1368473175-4841-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130531183828.GE599@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13, Stephen Boyd wrote:
> Separate the marco local timers from the local timer API. This
> will allow us to remove ARM local timer support in the near future
> and gets us closer to moving this driver to drivers/clocksource.
> 
> Cc: Barry Song <baohua.song@csr.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Barry, have you been able to test this patch?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
