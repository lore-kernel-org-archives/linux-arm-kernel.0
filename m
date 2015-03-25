From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 17:29:10 +0000
Subject: [patch v11 18/23] ARM64 / ACPI: Select
 ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64
In-Reply-To: <1427205776-5060-19-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325172910.GN14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:51PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> ACPI reduced hardware mode is disabled by default, but ARM64
> can only run properly in ACPI hardware reduced mode, so select
> ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.
> 
> If the firmware is not using hardware reduced ACPI mode, we
> will disable ACPI to avoid nightmare such as accessing some
> registers which are not available on ARM64.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
