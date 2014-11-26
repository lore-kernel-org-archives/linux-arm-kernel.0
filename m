From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 14:42:54 -0800
Subject: [PATCH 04/10] arm: dts: qcom: Add power-controller device node
 for 8074 Krait CPUs
In-Reply-To: <1417040910-43290-5-git-send-email-lina.iyer@linaro.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org>
 <1417040910-43290-5-git-send-email-lina.iyer@linaro.org>
Message-ID: <5476576E.6010608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 02:28 PM, Lina Iyer wrote:
> Each Krait CPU in the QCOM 8074/8974 SoC has an SAW power controller to
> regulate the power to the cpu and aide the core in entering idle states.
> Reference the SAW instance and associate the instance with the CPU core.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

I imagine all these dts changes will go through qcom tree -> arm-soc?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
