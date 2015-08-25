From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Aug 2015 17:25:04 -0700
Subject: [PATCH v4 2/3] ARM: qcom: add SMEM device node to IPQ806x dts
In-Reply-To: <1439931860-7473-3-git-send-email-mathieu@codeaurora.org>
References: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
 <1439931860-7473-3-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150825002504.GC19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Mathieu Olivari wrote:
> SMEM is used on IPQ806x to store various board related information such
> as boot device and flash partition layout. We'll declare it as a device
> so we can make use of it thanks to the new SMEM soc driver.
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
