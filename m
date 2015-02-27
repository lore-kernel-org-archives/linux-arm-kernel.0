From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 27 Feb 2015 18:53:06 +0800
Subject: [PATCH v9 20/21] Documentation: ACPI for ARM64
In-Reply-To: <1424853601-6675-21-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-21-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54F04C92.6010206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/25 16:40, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Add documentation for the guidelines of how to use ACPI
> on ARM64.
> 
> Reviewed-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Reviewed-by: Yi Li <phoenix.liyi@huawei.com>
> Reviewed-by: Mark Langsdorf <mlangsdo@redhat.com>
> Reviewed-by: Ashwin Chaugule <ashwinc@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/arm64/arm-acpi.txt | 506 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 506 insertions(+)
>  create mode 100644 Documentation/arm64/arm-acpi.txt
> 
> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
> new file mode 100644
> index 0000000..24cf832
> --- /dev/null
> +++ b/Documentation/arm64/arm-acpi.txt
> @@ -0,0 +1,506 @@
> +ACPI on ARMv8 Servers
> +---------------------
> +ACPI can be used for ARMv8 general purpose servers designed to follow
> +the ARM SBSA (Server Base System Architecture) [0] and SBBR (Server
> +Base Boot Requirements) [1] specifications.  Please note that the SBBR
> +can be retrieved simply by visiting [1], but the SBSA is currently only
> +available to those with an ARM login due to ARM IP licensing concerns.
> +
> +The ARMv8 kernel implements the reduced hardware model of ACPI version
> +5.1 or later.  Links to the specification and all external documents
> +it refers to are managed by the UEFI Forum.  The specification is
> +available at http://www.uefi.org/specifications and documents referenced
> +by the specification can be found via http://www.uefi.org/acpi.
> +
> +If an ARMv8 system does not meet the requirements of the SBSA and SBBR,
> +or cannot be described using the mechanisms defined in the required ACPI
> +specifications, then ACPI may not be a good fit for the hardware.
> +
> +While the documents mentioned above set out the requirements for building
> +industry-standard ARMv8 servers, they also apply to more than one operating
> +system.  The purpose of this document is to describe the interaction between
> +ACPI and Linux only, on an ARMv8 system -- that is, what Linux expects of
> +ACPI and what ACPI can expect of Linux.
> +
> +

Here. Two blank lines.

> +Why ACPI on ARM?


-- 
Thanks,
Shannon
