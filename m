From: agross@codeaurora.org (Andy Gross)
Date: Tue, 25 Aug 2015 16:24:09 -0500
Subject: [PATCH v2 4/6] ARM: dts: qs600: remove unnecessary i2c pinctrl
 nodes in board file.
In-Reply-To: <1439903419-20275-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1439903419-20275-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150825212409.GB12349@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 02:10:19PM +0100, Srinivas Kandagatla wrote:
> This patch removes unnecessary i2c pinctrl nodes in board file, these
> are already defined in the soc specific file qcom-apq8064.dtsi.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 9 ---------
>  1 file changed, 9 deletions(-)

Applied, thanks!

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
