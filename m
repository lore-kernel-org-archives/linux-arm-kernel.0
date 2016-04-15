From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Apr 2016 09:42:26 +0100
Subject: [PATCH 3/3] arm64: defconfig: Enable ACPI
In-Reply-To: <1460706823-16566-3-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
 <1460706823-16566-3-git-send-email-broonie@kernel.org>
Message-ID: <20160415084226.GH15182@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 08:53:43AM +0100, Mark Brown wrote:
> Enable ACPI by default to support testing of ACPI only systems and
> ensure that defconfig will boot on anything, for arm64 this is not done
> in Kconfig since a very large proportion of arm64 systems have no ACPI
> at all.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
