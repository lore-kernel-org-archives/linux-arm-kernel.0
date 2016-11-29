From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Nov 2016 19:11:45 +0800
Subject: [PATCH v9 00/16] ACPI IORT ARM SMMU support
In-Reply-To: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
Message-ID: <af1d9b6c-1229-4e2c-918c-423ae5a48afd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> This patch series is v9 of a previous posting:
>
> https://lkml.org/lkml/2016/11/16/386
>
> v8 -> v9
> 	- Updated bypass flag handling in ARM SMMU v3 according to
> 	  reviews
> 	- Removed SMMUv1/v2 configuration interrupt handling
> 	- Rebased against v4.9-rc5
> 	- Updated tags

I rebased on top of latest 4.9-rc7 (can apply cleanly), and tested on
Hisilicon D03, the SMMUv3 works fine as previous version.

Thanks
Hanjun
