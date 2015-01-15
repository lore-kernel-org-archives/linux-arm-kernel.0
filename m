From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:45:24 -0600
Subject: [PATCH v7 03/17] ARM64 / ACPI: Introduce sleep-arm.c
In-Reply-To: <1421247905-3749-4-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80AC4.2030504@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> ACPI 5.1 does not currently support S states for ARM64 hardware but
> ACPI code will call acpi_target_system_state() for device power
> managment, so introduce sleep-arm.c to allow other drivers to function
> until S states are defined.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
