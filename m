From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 29 Oct 2012 11:16:35 -0700
Subject: [PATCH 0/3] Minor fixes for generic clock framework
In-Reply-To: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
References: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20121029181635.18780.15399@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2012-10-03 23:38:52)
> This is a small set of patches that fixes some documentation
> and fixes return values of functions that aren't used that
> much yet. Noticed while going through this code.
> 

Taken into clk-next.

Thanks,
Mike

> Stephen Boyd (3):
>   clk: Document .is_enabled op
>   clk: Fix documentation typos
>   clk: Don't return negative numbers for unsigned values with !clk
> 
>  drivers/clk/clk.c            | 20 ++++++++++----------
>  include/linux/clk-provider.h | 16 ++++++++++------
>  2 files changed, 20 insertions(+), 16 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
