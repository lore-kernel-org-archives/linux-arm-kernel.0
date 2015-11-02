From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 02 Nov 2015 15:06:24 -0500
Subject: [PATCH v4 05/21] KVM: ARM64: Add reset and access
 handlers for PMSELR register
In-Reply-To: <1446186123-11548-6-git-send-email-zhaoshenglong@huawei.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>
 <1446186123-11548-6-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <5637C240.8090803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2015 02:21 AM, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since the reset value of PMSELR_EL0 is UNKNOWN, use reset_unknown for
> its reset handler. As it doesn't need to deal with the acsessing action

Nit: accessing

> specially, it uses default case to emulate writing and reading PMSELR
> register.
> 
> Add a helper for CP15 registers reset to UNKNOWN.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
