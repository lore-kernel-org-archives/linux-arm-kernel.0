From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 10 Oct 2017 15:59:32 +0800
Subject: [PATCH 1/3] ACPI/IORT: Remove leftover
 ACPI_IORT_SMMU_V3_PXM_VALID guard
In-Reply-To: <1507038811-23382-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <59DC7DE4.90409@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/3 21:53, Lorenzo Pieralisi wrote:
> The conditional ACPI_IORT_SMMU_V3_PXM_VALID guard around
> arm_smmu_v3_set_proximity() was added to manage a cross tree
> ACPICA merge dependency; with ACPICA changes merged in:
>
> commit c944230064eb ("ACPICA: iasl: Update to IORT SMMUv3
> disassembling")
>
> the guard has become useless. Remove it.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
