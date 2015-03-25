From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 16:25:34 +0000
Subject: [PATCH 5/5] ARM64: kernel: acpi: honour acpi=force command line
 parameter
In-Reply-To: <1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150325162533.GG26903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 05:58:55PM +0000, Lorenzo Pieralisi wrote:
> If acpi=force is passed on the command line, it forces ACPI to be
> the only available boot method, hence it must be left enabled even
> if the initialization and sanity checks on ACPI tables fails.
> 
> This patch refactors ACPI initialization to prevent disabling ACPI
> if acpi=force is passed on the command line.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Better, indeed.
