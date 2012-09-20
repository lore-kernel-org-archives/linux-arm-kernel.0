From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Thu, 20 Sep 2012 13:14:17 -0700
Subject: [PATCH 4/5] gpio: Make gpio-msm-v1 into a platform driver
In-Reply-To: <1348038044-1790-5-git-send-email-sboyd@codeaurora.org>
References: <1348038044-1790-1-git-send-email-sboyd@codeaurora.org>
 <1348038044-1790-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <505B7919.6020206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/2012 12:00 AM, Stephen Boyd wrote:
> Doing this removes the dependence of this driver on the
> msm_iomap.h and cpu.h mach include headers provied by MSM. This
> is necessary to support single zImage work in the future and
> allows us to remove cpu.h entirely and brings us closer to
> removing msm_iomap.h.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rohit Vaswani <rvaswani@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>   arch/arm/mach-msm/board-halibut.c   |   1 +
>   arch/arm/mach-msm/board-msm7x30.c   |   1 +
>   arch/arm/mach-msm/board-qsd8x50.c   |   1 +
>   arch/arm/mach-msm/board-trout.c     |   1 +
>   arch/arm/mach-msm/devices-msm7x00.c |  31 +++++
>   arch/arm/mach-msm/devices-msm7x30.c |  31 +++++
>   arch/arm/mach-msm/devices-qsd8x50.c |  31 +++++
>   arch/arm/mach-msm/devices.h         |   4 +
>   drivers/gpio/gpio-msm-v1.c          | 220 ++++++++++++++++++++++++------------
>   9 files changed, 250 insertions(+), 71 deletions(-)
>

Tested-by: Rohit Vaswani <rvaswani@codeaurora.org>
Acked-by: Rohit Vaswani <rvaswani@codeaurora.org>

Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
