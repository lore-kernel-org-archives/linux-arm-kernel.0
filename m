From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Jun 2013 17:42:57 +0100
Subject: [PATCH 0/3] clk: Add APM X-Gene SoC clock driver
In-Reply-To: <1371828605-18053-1-git-send-email-lho@apm.com>
References: <1371828605-18053-1-git-send-email-lho@apm.com>
Message-ID: <20130621164257.GB25228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 04:30:02PM +0100, Loc Ho wrote:
> This patch adds APM X-Gene SoC clock driver support. Reference,
> PCP PLL, SoC PCP, and Ethernet clocks are defined via the DTS.
> 
> Loc Ho (3):
>   clk: Add APM X-Gene SoC clock driver with reference, PLL, and device
>     clocks.
>   clk: arm64: Add DTS clock entry for APM X-Gene Storm SoC.
>   Documentation: Add documentation for APM X-Gene clock binding.
> 
>  Documentation/devicetree/bindings/clock/xgene.txt |   90 ++++
>  arch/arm64/boot/dts/apm-storm.dtsi                |   75 +++
>  drivers/clk/Kconfig                               |    7 +
>  drivers/clk/Makefile                              |    1 +
>  drivers/clk/clk-xgene.c                           |  538 +++++++++++++++++++++
>  5 files changed, 711 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/xgene.txt
>  create mode 100644 drivers/clk/clk-xgene.c

You'll have to send these patches to Mike Turquette (cc'ed), they are
not being merged via the arm64 tree.

Thanks.

-- 
Catalin
