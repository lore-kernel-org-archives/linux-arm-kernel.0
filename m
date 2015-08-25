From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Aug 2015 17:24:42 -0700
Subject: [PATCH v4 1/3] ARM: qcom: add SFPB nodes to IPQ806x dts
In-Reply-To: <1439931860-7473-2-git-send-email-mathieu@codeaurora.org>
References: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
 <1439931860-7473-2-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150825002442.GB19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Mathieu Olivari wrote:
> Add one new node to the ipq806x.dtsi file to declare & register the
> hardware spinlock devices. This mechanism is required to be used by
> other drivers such as SMEM.
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
