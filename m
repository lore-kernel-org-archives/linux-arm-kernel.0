From: davidb@codeaurora.org (David Brown)
Date: Thu, 27 Feb 2014 14:14:58 -0800
Subject: [PATCH 3/3] ARM: config: Update msm_defconfig
In-Reply-To: <1393467394-10907-4-git-send-email-sboyd@codeaurora.org>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
 <1393467394-10907-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227221458.GA5334@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 06:16:34PM -0800, Stephen Boyd wrote:
>Now that DT based platforms are split out of mach-msm into
>mach-qcom, put back a non-DT based SoC into the msm_defconfig and
>stop selecting unsupported drivers.
>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> arch/arm/configs/msm_defconfig | 25 +++----------------------
> 1 file changed, 3 insertions(+), 22 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

Kumar, can you just pull this in with the other qcom changes from
Sephen?

Thanks,
David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
