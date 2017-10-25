From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 25 Oct 2017 09:01:05 +0200
Subject: [PATCH 2/3] arm64: defconfig: remove CONFIG_USB_MSM_OTG
In-Reply-To: <20171020172021.8119-3-elder@linaro.org>
References: <20171020172021.8119-1-elder@linaro.org>
 <20171020172021.8119-3-elder@linaro.org>
Message-ID: <20171025070105.GB28555@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 12:20:20PM -0500, Alex Elder wrote:
> No Qualcomm SoC requires the "phy-msm-usb.c" USB phy driver support
> any more.  Remove the code, and remove the config option from the
> arm64 defconfig.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
