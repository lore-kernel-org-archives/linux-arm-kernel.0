From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 25 Oct 2017 09:01:37 +0200
Subject: [PATCH 3/3] arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY
In-Reply-To: <20171020172021.8119-4-elder@linaro.org>
References: <20171020172021.8119-1-elder@linaro.org>
 <20171020172021.8119-4-elder@linaro.org>
Message-ID: <20171025070137.GC28555@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 12:20:21PM -0500, Alex Elder wrote:
> No Qualcomm SoC requires the "phy-qcom-8x16-usb.c" USB phy driver
> support any more.  Remove the code, and remove the config option
> from the arm64 defconfig.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
