From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:47:43 -0600
Subject: [PATCH v7 09/17] ACPI / table: Print GIC information when MADT
 is parsed
In-Reply-To: <1421247905-3749-10-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-10-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80B4F.6090303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> When MADT is parsed, print GIC information to make the boot
> log look pretty:
>
> ACPI: GICC (acpi_id[0x0000] address[00000000e112f000] MPIDR[0x0] enabled)
> ACPI: GICC (acpi_id[0x0001] address[00000000e112f000] MPIDR[0x1] enabled)
> ...
> ACPI: GICC (acpi_id[0x0201] address[00000000e112f000] MPIDR[0x201] enabled)
>
> These information will be very helpful to bring up early systems to
> see if acpi_id and MPIDR are matched or not as spec defined.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
