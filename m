From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 21:57:10 -0500
Subject: [PATCH v6 02/10] clocksource: arm_arch_timer: Extend
 arch_timer_kvm_info to get the virtual IRQ
In-Reply-To: <1460388780-914-3-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-3-git-send-email-julien.grall@arm.com>
Message-ID: <571C3606.3030101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:32 AM, Julien Grall wrote:
> Currently, the firmware table is parsed by the virtual timer code in
> order to retrieve the virtual timer interrupt. However, this is already
> done by the arch timer driver.
>
> To avoid code duplication, extend arch_timer_kvm_info to get the virtual
> IRQ.
>
> Note that the KVM code will be modified in a subsequent patch.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

Using the Qualcomm Technologies QDF2XXX server platform.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
