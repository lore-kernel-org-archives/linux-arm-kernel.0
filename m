From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 31 Oct 2017 09:46:33 -0400 (EDT)
Subject: [PATCH v3 1/3] usb: host: remove ehci-msm.c
In-Reply-To: <20171031131131.8099-2-elder@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1710310945580.10104-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Oct 2017, Alex Elder wrote:

> No Qualcomm SoC requires the "ehci-msm.c" code any more.  So remove it.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/usb/host/Kconfig    |  12 --
>  drivers/usb/host/Makefile   |   1 -
>  drivers/usb/host/ehci-msm.c | 265 --------------------------------------------
>  3 files changed, 278 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-msm.c

Acked-by: Alan Stern <stern@rowland.harvard.edu>
