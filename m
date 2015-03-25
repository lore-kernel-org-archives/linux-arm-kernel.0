From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 25 Mar 2015 21:29:49 +0800
Subject: [PATCH 2/5] ARM64: kernel: psci: factor out probe function
In-Reply-To: <1427219940-27201-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5512B84D.4090705@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/25 1:58, Lorenzo Pieralisi wrote:
> PSCI v0.2+ versions provide a specific PSCI call (PSCI_VERSION) to
> detect the PSCI version at run-time. Current PSCI v0.2 init code
> carries out the version probing in the PSCI 0.2 DT init function,
> but the version probing does not depend on DT so it can be factored out
> in order to make it available to other boot mechanisms (ie ACPI) to
> reuse. The psci_probe() probing function can be easily extended
> to add detection and initialization of PSCI functions defined in
> PSCI versions >0.2.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---

This cleanup looks pretty fine to me,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
