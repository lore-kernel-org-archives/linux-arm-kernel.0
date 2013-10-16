From: davidb@codeaurora.org (David Brown)
Date: Wed, 16 Oct 2013 11:26:37 -0700
Subject: [PATCH 3/4] ARM: debug: msm: Add DEBUG_LL support for ARCH_MSM8974
In-Reply-To: <1380841557-2673-4-git-send-email-rvaswani@codeaurora.org>
References: <1380841557-2673-1-git-send-email-rvaswani@codeaurora.org>
 <1380841557-2673-4-git-send-email-rvaswani@codeaurora.org>
Message-ID: <20131016182637.GA21292@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 04:05:56PM -0700, Rohit Vaswani wrote:
>Add debug uart support for MSM8974. This patch adds a Kconfig
>entry and the base address for the debug uart.
>
>Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
>---
> arch/arm/Kconfig.debug       | 9 +++++++++
> arch/arm/include/debug/msm.S | 5 +++++
> 2 files changed, 14 insertions(+)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
