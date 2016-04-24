From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 22:06:44 -0500
Subject: [PATCH v6 08/10] KVM: arm/arm64: arch_timer: Rely on the arch
 timer to parse the firmware tables
In-Reply-To: <1460388780-914-9-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-9-git-send-email-julien.grall@arm.com>
Message-ID: <571C3844.7090103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:32 AM, Julien Grall wrote:
> The firmware table is currently parsed by the virtual timer code in
> order to retrieve the virtual timer interrupt. However, this is already
> done by the arch timer driver.
>
> To avoid code duplication, use the newly function
> arch_timer_get_kvm_info()
> which return all the information required by the virtual timer code.
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
