From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 5 Apr 2017 15:51:30 -0700
Subject: [PATCH V7 4/4] phy: qcom-qmp: new qmp phy driver for qcom-chipsets
In-Reply-To: <1491395558-16902-5-git-send-email-vivek.gautam@codeaurora.org>
References: <1491395558-16902-1-git-send-email-vivek.gautam@codeaurora.org>
 <1491395558-16902-5-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <20170405225130.GN7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05, Vivek Gautam wrote:
> Qualcomm SOCs have QMP phy controller that provides support
> to a number of controller, viz. PCIe, UFS, and USB.
> Add a new driver, based on generic phy framework, for this
> phy controller.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
