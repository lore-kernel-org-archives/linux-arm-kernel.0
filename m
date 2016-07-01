From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 1 Jul 2016 09:14:25 -0500
Subject: [PATCH] arm64: defconfig: Enable QDF2432 config options
In-Reply-To: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
References: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
Message-ID: <57767AC1.3070209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christopher Covington wrote:
>   arch/arm64/configs/defconfig |  4 ++++
>   scripts/patch-details.sh     | 21 ++++++++++++++++++---

I don't think these two files should be combined.

>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MSM8916=y
> +CONFIG_PINCTRL_QDF2XXX=m
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_DWAPB=y
> @@ -245,6 +246,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_ARMMMCI=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ACPI=m
>  CONFIG_MMC_SDHCI_PLTFM=y

Why are these =m when all the others are =y?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
