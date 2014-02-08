From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Feb 2014 19:37:40 -0800
Subject: [PATCH] ARM: dts: qcom: Add RNG device tree node
In-Reply-To: <1391764987-17138-1-git-send-email-svarbanov@mm-sol.com>
References: <1391764987-17138-1-git-send-email-svarbanov@mm-sol.com>
Message-ID: <20140208033740.GD10784@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07, Stanimir Varbanov wrote:
> Add the necessary DT node to probe the rng driver on
> msm8974 platforms.
> 

Looks good. We should add it to msm8960-cdp and enable the driver
in the defconfig as well.

> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
