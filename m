From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Apr 2017 14:48:58 -0700
Subject: [PATCH v5 5/9] coresight: use const for device_node structures
In-Reply-To: <1490466197-29163-6-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-6-git-send-email-leo.yan@linaro.org>
Message-ID: <20170404214858.GG18246@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26, Leo Yan wrote:
> Almost low level functions from open firmware have used const to
> qualify device_node structures, so add const for device_node
> parameters in of_coresight related functions.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
