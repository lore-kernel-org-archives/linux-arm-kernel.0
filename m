From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 17 Apr 2017 18:01:35 -0400
Subject: [PATCH v8 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <838d8504-b6f0-2475-f4b1-9761ecd9f573@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <1484744105-53140-11-git-send-email-guohanjun@huawei.com>
 <838d8504-b6f0-2475-f4b1-9761ecd9f573@codeaurora.org>
Message-ID: <9556e737-a9d8-f751-2872-6fabce86fa48@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2017 5:44 PM, Sinan Kaya wrote:
> Any idea what happened to the change in this function during merge?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ae7c18380495ac5c14a614fdb6c452c3bf9148ac
> 

I realized that there is a V9 out there. I'm catching up with the work. 

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-4.12&id=e6db07d0f3b6da1f8cfd485776bfefa4fcdbfc45

seems to be fixing the issue. 

> 63a52b3 platform-msi: Make platform_msi_create_device_domain() ACPI aware
> e07b978 irqchip/gicv3-its: platform-msi: Scan MADT to create platform msi domain
> 09be1d5 irqchip/gicv3-its: platform-msi: Refactor its_pmsi_init() to prepare for ACPI
> 4e96df9 irqchip/gicv3-its: platform-msi: Refactor its_pmsi_prepare()
> e593828 irqchip/gic-v3-its: Keep the include header files in alphabetic order
> e226a74 ACPI: platform: setup MSI domain for ACPI based platform device
> 79c7533 ACPI: platform-msi: retrieve devid from IORT
> 43394c9 ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
> e6eaeae ACPI/IORT: Rename iort_node_map_rid() to make it generic
> 6acbb92 ACPI/IORT: Rework iort_match_node_callback() return value handling
> f8e2f50 ACPI/IORT: Add missing comment for iort_dev_find_its_id()
> 4b1eeee ACPI/IORT: Fix the indentation in iort_scan_node()

Apologies for the noise.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
