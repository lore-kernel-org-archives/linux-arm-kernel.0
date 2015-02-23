From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Feb 2015 11:04:36 -0800
Subject: [PATCH 1/3] watchdog: qcom: use timer devicetree binding
In-Reply-To: <1424485176-8348-2-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
 <1424485176-8348-2-git-send-email-mathieu@codeaurora.org>
Message-ID: <54EB79C4.50405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/15 18:19, Mathieu Olivari wrote:
> MSM watchdog configuration happens in the same register block as the
> timer, so we'll use the same binding as the existing timer.
>
> The qcom-wdt will now be probed when devicetree has an entry compatible
> with "qcom,kpss-timer" or "qcom-scss-timer".
>
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
