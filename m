From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:48:23 -0600
Subject: [PATCH v7 11/17] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <1421247905-3749-12-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80B77.3080601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
> from the GICC Structure introduced by ACPI 5.1.
>
> MPIDR is the CPU hardware ID as local APIC ID on x86 platform, so we use
> MPIDR not the GIC CPU interface ID to identify CPUs.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
