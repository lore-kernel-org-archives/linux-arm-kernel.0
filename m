From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 12:16:02 -0800
Subject: [PATCH v10 09/10] arm: dts: qcom: Add idle states device nodes
 for 8084
In-Reply-To: <1416593037-27527-10-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-10-git-send-email-lina.iyer@linaro.org>
Message-ID: <54763502.90709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> Add ARM common idle states device bindings for cpuidle support for APQ
> 8084.
>
> Support standby and standalone power collapse (power down that does not
> affect any SoC idle states) for each cpu.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
