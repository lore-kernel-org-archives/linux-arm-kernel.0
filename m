From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Fri, 18 Nov 2016 17:53:40 -0800
Subject: [PATCH] arm64: dts: qcom: msm8996: Fixup smp2p node
In-Reply-To: <1479499609-13336-1-git-send-email-bjorn.andersson@linaro.org>
References: <1479499609-13336-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <e729b75a-3e0c-2462-67a7-d3a0f4b3368c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2016 12:06 PM, Bjorn Andersson wrote:
> The SMEM state property name changes between the integration branch and
> mainline, update to use the correct one.
>
> Fixes: 2f45d9fcd531 ("arm64: dts: msm8996: Add SMP2P and APCS nodes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks for the change and sorry for missing it earlier.

Reviewed-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
