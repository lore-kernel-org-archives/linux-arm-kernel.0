From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 25 Oct 2017 09:00:21 +0200
Subject: [PATCH 1/3] arm64: defconfig: remove CONFIG_USB_EHCI_MSM
In-Reply-To: <20171020172021.8119-2-elder@linaro.org>
References: <20171020172021.8119-1-elder@linaro.org>
 <20171020172021.8119-2-elder@linaro.org>
Message-ID: <20171025070021.GA28555@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 12:20:19PM -0500, Alex Elder wrote:
> No Qualcomm SoC requires the "ehci-msm.c" code any more.  So remove
> the code, and remove the config option from the arm64 defconfig.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
