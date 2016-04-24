From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 22:33:54 -0500
Subject: [PATCH v6 10/10] clocksource: arm_arch_timer: Remove
 arch_timer_get_timecounter
In-Reply-To: <1460388780-914-11-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-11-git-send-email-julien.grall@arm.com>
Message-ID: <571C3EA2.1030001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:33 AM, Julien Grall wrote:
> The only call of arch_timer_get_timecounter (in KVM) has been removed.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

Using the Qualcomm Technologies QDF2XXX server.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
