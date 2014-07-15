From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 15 Jul 2014 09:50:56 -0500
Subject: [PATCH v5 1/2] phy: qcom: Add driver for QCOM IPQ806x SATA PHY
In-Reply-To: <1403030008-20675-1-git-send-email-galak@codeaurora.org>
References: <1403030008-20675-1-git-send-email-galak@codeaurora.org>
Message-ID: <3ABB6878-6EED-452A-BE5F-4240EA237BF7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 17, 2014, at 1:33 PM, Kumar Gala <galak@codeaurora.org> wrote:

> Add a PHY driver for uses with AHCI based SATA controller driver on the
> IPQ806x family of SoCs.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v5:
> * Fix copy/paste error when killing qcom_ipq806x_sata_delay_us
> 
> v4:
> * removed qcom_ipq806x_sata_delay_us as it was only used one
> 
> v3:
> * Added Kconfig HAS_IOMEM dep
> * re-ordered probe function so phy_provider_register is last
> 
> v2:
> * dropped unused dev pointer in struct qcom_ipq806x_sata_phy
> * remove unnecessary reg initializaiton
> * Removed unneeded error message
> * Added remove function to disable the clock
> 
> drivers/phy/Kconfig                 |   7 ++
> drivers/phy/Makefile                |   1 +
> drivers/phy/phy-qcom-ipq806x-sata.c | 206 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 214 insertions(+)
> create mode 100644 drivers/phy/phy-qcom-ipq806x-sata.c

any update?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
