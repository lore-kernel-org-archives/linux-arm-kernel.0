From: davidb@codeaurora.org (David Brown)
Date: Tue, 05 Mar 2013 11:04:57 -0800
Subject: [PATCH 5/8] ARM: MSM: Divorce msm_timer from local timer API
In-Reply-To: <1361518039-16663-6-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Thu, 21 Feb 2013 23:27:16 -0800")
References: <1361518039-16663-1-git-send-email-sboyd@codeaurora.org>
 <1361518039-16663-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <8yad2vd1xd2.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> Separate the msm_timer from the local timer API. This will allow
> us to remove ARM local timer support in the near future and gets
> us closer to moving this driver to drivers/clocksource.
>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-msm/timer.c | 125 +++++++++++++++++++++++++---------------------

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
