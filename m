From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 17:31:07 +0000
Subject: [patch v11 23/23] ARM64 / ACPI: Don't unflatten device tree if
 acpi=force is passed
In-Reply-To: <1427205776-5060-24-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-24-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325173107.GQ14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:56PM +0800, Hanjun Guo wrote:
> Since the policy is that once we pass acpi=force in the early
> param, we will not unflatten device tree even if ACPI is disabled
> in ACPI table init fails, so fix the code by comparinging both
> acpi_disabled and param_acpi_force before the device tree is
> unflattened.
> 
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

but as I said, we should take Lorenzo's patch on top as well.
