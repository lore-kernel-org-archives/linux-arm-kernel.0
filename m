From: agross@codeaurora.org (Andy Gross)
Date: Thu, 23 Jul 2015 15:59:43 -0500
Subject: [PATCH 1/5] ARM: dts: qcom: Replace gpio node with pinctrl node
In-Reply-To: <1434486676-21812-2-git-send-email-sboyd@codeaurora.org>
References: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
 <1434486676-21812-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150723205943.GF13658@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 01:31:12PM -0700, Stephen Boyd wrote:
> Now that we have a proper pinctrl driver for the gpio block we
> can change the compatible field here and configure the pinmux on
> msm8960 devices.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied, thanks

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
