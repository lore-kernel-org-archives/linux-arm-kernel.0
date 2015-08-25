From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Aug 2015 17:35:21 -0700
Subject: [PATCH v4 3/3] mtd: add SMEM parser for QCOM platforms
In-Reply-To: <1439931860-7473-4-git-send-email-mathieu@codeaurora.org>
References: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
 <1439931860-7473-4-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150825003521.GD19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Mathieu Olivari wrote:
> On QCOM platforms using MTD devices storage (such as IPQ806x), SMEM is
> used to store partition layout. This new parser can now be used to read
> SMEM and use it to register an MTD layout according to its content.
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
