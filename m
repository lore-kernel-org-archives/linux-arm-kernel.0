From: agross@codeaurora.org (Andy Gross)
Date: Sun, 4 Oct 2015 23:18:03 -0500
Subject: [PATCH] ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs
In-Reply-To: <1443704258-3180-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443704258-3180-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151005041803.GB28066@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 01:57:38PM +0100, Srinivas Kandagatla wrote:
> This patch adds few missing essential configs in the multi_v7_defconf,
> absense of some configs like PINCTRL_APQ8064 would prevent the board from
> getting access to serial.
> 
> cc: Kevin Hilman <khilman@kernel.org>
> cc: Tyler Baker <tyler.baker@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)

Works like a charm.

Tested-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
