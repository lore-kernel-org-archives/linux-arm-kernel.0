From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 1 May 2017 10:46:38 -0500
Subject: [PATCH 0/9] [v3] arm64: defconfig: enable several options useful
 for ARM64 server platforms
In-Reply-To: <1493413563-18375-1-git-send-email-timur@codeaurora.org>
References: <1493413563-18375-1-git-send-email-timur@codeaurora.org>
Message-ID: <00b185fa-3fd5-664e-345e-35292d55feb0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2017 04:05 PM, Timur Tabi wrote:
> Timur Tabi (9):
>   [v3] arm64: defconfig: resynchronize the defconfig
>   arm64: defconfig: enable ACPI_CPPC_CPUFREQ
>   arm64: defconfig: enable BLK_DEV_NVME
>   [v2] arm64: defconfig: enable EFI_CAPSULE_LOADER
>   arm64: defconfig: enable support for PCIe hotplug
>   arm64: defconfig: enable APEI and GHES features
>   [v2] arm64: defconfig: enable EDAC options
>   arm64: defconfig: enable QCOM_L2_PMU and QCOM_L3_PMU
>   arm64: defconfig: enable the Qualcomm Technologies EMAC Ethernet
>     driver

Catalin,

Any chance of getting these into 4.12?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
