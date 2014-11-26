From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 12:06:53 -0800
Subject: [PATCH v10 06/10] arm: dts: qcom: Update power-controller device
 node for 8064 Krait CPUs
In-Reply-To: <1416593037-27527-7-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-7-git-send-email-lina.iyer@linaro.org>
Message-ID: <547632DD.4030005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> Update the SAW2 DT bindings to add qcom,apq8064-saw2-v1.1-cpu compatible
> binding string to configure SPM registers and allow the SPM to put the
> core in deeper idle states when the core is idle.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
