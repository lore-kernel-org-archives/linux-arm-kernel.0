From: jackp@codeaurora.org (Jack Pham)
Date: Thu, 22 Jan 2015 10:59:14 -0800
Subject: [Patch v9 3/3] phy: Add Qualcomm DWC3 HS/SS PHY driver
In-Reply-To: <1410550088-8754-4-git-send-email-agross@codeaurora.org>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-4-git-send-email-agross@codeaurora.org>
Message-ID: <20150122185914.GA4114@usblab-sd-06.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Fri, Sep 12, 2014 at 02:28:08PM -0500, Andy Gross wrote:
> This patch adds a new driver for the Qualcomm USB 3.0 PHY that exists on some
> Qualcomm platforms.  This driver uses the generic PHY framework and will
> interact with the DWC3 controller.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/phy/Kconfig         |   11 +
>  drivers/phy/Makefile        |    1 +
>  drivers/phy/phy-qcom-dwc3.c |  483 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 495 insertions(+)
>  create mode 100644 drivers/phy/phy-qcom-dwc3.c

What happened to this patch? Looks like [1/3] & [2/3] made it in during
the 3.18 merge, but did this one not get picked up by Kishon?

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
