From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2016 11:40:14 +0100
Subject: [PATCH v6 14/14] acpi, numa: Enable ACPI based NUMA on ARM64
In-Reply-To: <1461780436-27182-15-git-send-email-ddaney.cavm@gmail.com>
References: <1461780436-27182-1-git-send-email-ddaney.cavm@gmail.com>
 <1461780436-27182-15-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160511104014.GD3051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 11:07:16AM -0700, David Daney wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Add function needed for cpu to node mapping, and enable ACPI based
> NUMA for ARM64 in Kconfig
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> [david.daney at cavium.com added ACPI_NUMA default to y for ARM64]
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
