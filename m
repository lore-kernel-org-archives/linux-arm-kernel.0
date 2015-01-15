From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:46:44 -0600
Subject: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on ARM64
In-Reply-To: <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80B14.2080808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> Since PCI is not required in ACPI spec and ARM can run without
> it, introduce some stub functions to make PCI optional for ACPI,
> and make ACPI core run without CONFIG_PCI on ARM64.
>
> When PCI is enabled on ARM64, ACPI core will need some PCI functions
> to make it functional, so introduce some empty functions here and
> implement it later.
>
> Since ACPI on X86 and IA64 depends on PCI and this patch only makes
> PCI optional for ARM64, it will not break anything on X86 and IA64.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
