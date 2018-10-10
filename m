From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Oct 2018 11:37:01 +0100
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Add SPDX header
In-Reply-To: <1539167367-20471-2-git-send-email-andrew.murray@arm.com>
References: <1539167367-20471-1-git-send-email-andrew.murray@arm.com>
 <1539167367-20471-2-git-send-email-andrew.murray@arm.com>
Message-ID: <57f6c723-a0a6-ccdb-d5c7-25258e13fe15@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/18 11:29, Andrew Murray wrote:
> Replace license text with SDPX header

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index db402e8..c7bd18e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1,18 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * IOMMU API for ARM architected SMMUv3 implementations.
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
>    * Copyright (C) 2015 ARM Limited
>    *
>    * Author: Will Deacon <will.deacon@arm.com>
> 
