From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jan 2012 19:52:52 -0800
Subject: [PATCH v2] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <1325770305-21637-1-git-send-email-pdeschrijver@nvidia.com>
References: <1325770305-21637-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120119035252.GB7145@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 03:31:45PM +0200, Peter De Schrijver wrote:
> Tegra30 has 1 extra legacy interrupt controller. Use the GIC ITLinesNumber
> field to determine how many interrupt controllers we have and initialize
> appropriately. Also make room for the extra tegra30 interrupts by moving
> the GPIO IRQ base. This shouldn't affect existing code as it determines the
> correct IRQ number for GPIOs using TEGRA_GPIO_TO_IRQ().
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Colin Cross <ccross@android.com>

Thanks, applied.


-Olof
