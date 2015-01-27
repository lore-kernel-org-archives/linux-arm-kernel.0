From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 27 Jan 2015 11:46:53 -0600
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54C7CF0D.4050607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
>

Tested-by: Timur Tabi <timur@codeaurora.org>

However, these 17 patches are insufficient to make ACPI work completely 
on ARM64.  I need to add two patches:

acpi: add arm to the platforms that use ioremap
http://lists.linaro.org/pipermail/linaro-acpi/2014-November/002943.html

acpi: fix acpi_os_ioremap for arm64
http://lists.linaro.org/pipermail/linaro-acpi/2014-November/002859.html

Without these two patches, my ACPI-based device drivers don't probe. 
Can we add them to this 17-patch patchset?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
