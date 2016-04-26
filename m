From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Apr 2016 18:29:48 -0700
Subject: [Patch v2 3/8] firmware: qcom: scm: Generalize shared error map
In-Reply-To: <1461625725-32425-4-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
 <1461625725-32425-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20160426012948.GF29990@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Andy Gross wrote:
> This patch moves the qcom_scm_remap_error function to the include file
> where can be used by both the 32 and 64 bit versions of the code.
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
