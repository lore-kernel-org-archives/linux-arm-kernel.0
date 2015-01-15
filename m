From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:50:04 -0600
Subject: [PATCH v7 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <1421247905-3749-14-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-14-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80BDC.8030901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:05 AM, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> parse GIC related subtables, collect CPU interface and distributor
> addresses and call driver initialization function (which is hardware
> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
>
> NOTE: This commit allow to initialize GICv1/2 basic functionality.
> GICv2 vitalization extension, GICv3/4 and ITS are considered as next
> steps.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
