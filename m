From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 11 Nov 2016 20:44:38 +0800
Subject: [PATCH v7 00/16] ACPI IORT ARM SMMU support
In-Reply-To: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Message-ID: <5825BD36.1040600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2016 10:19 PM, Lorenzo Pieralisi wrote:
> This patch series is v7 of a previous posting:
>
> https://lkml.org/lkml/2016/10/18/506
>
> v6 -> v7
> 	- Rebased against v4.9-rc4
> 	- Fixed IORT probing on ACPI systems with missing IORT table
> 	- Fixed SMMUv1/v2 global interrupt detection
> 	- Updated iommu_ops firmware look-up

Although no major update for the new version, I tested
this patchset again on hisilicon d03, and the platform
device works as before with SMMUv3.

Thanks
Hanjun
