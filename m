From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:11:57 +0100
Subject: [PATCH v4 12/13] arm64: acpi: Remove __init from
 acpi_psci_use_hvc() for use by SDEI
In-Reply-To: <20171017174432.1684-13-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-13-james.morse@arm.com>
Message-ID: <20171018111157.lqzouwbsqrm2expe@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:31PM +0100, James Morse wrote:
> SDEI inherits the 'use hvc' bit that is also used by PSCI. PSCI does all
> its initialisation early, SDEI does its late.
> 
> Remove the __init annotation from acpi_psci_use_hvc().
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
