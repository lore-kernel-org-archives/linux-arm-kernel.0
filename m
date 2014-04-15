From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Apr 2014 10:56:14 -0700
Subject: [PATCH] clk: qcom: Consolidate common probe code
In-Reply-To: <1395449977-2401-1-git-send-email-sboyd@codeaurora.org>
References: <1395449977-2401-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <534D72BE.4050300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/14 17:59, Stephen Boyd wrote:
> Most of the probe code is the same between all the different
> clock controllers. Consolidate the code into a common.c file.
> This makes changes to the common probe parts easier and reduces
> chances for bugs.
>
>

ping?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
