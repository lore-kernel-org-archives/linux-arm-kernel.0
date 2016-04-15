From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Apr 2016 09:42:49 +0100
Subject: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Message-ID: <20160415084249.GI15182@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 08:53:41AM +0100, Mark Brown wrote:
> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
