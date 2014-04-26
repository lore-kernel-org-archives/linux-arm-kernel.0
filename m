From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 21:11:54 -0400
Subject: [PATCH v2 04/38] clk: mvebu: add Orion5x clock driver
In-Reply-To: <1398202002-28530-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140426011154.GS28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 11:26:08PM +0200, Thomas Petazzoni wrote:
> This commit adds a core clock driver for the Orion5x SoC, with support
> for the tclk, the CPU frequency and the DDR frequency. All the details
> about the Sample-At-Reset register were extracted from the U-Boot
> sources for Orion5x.
> 
> Note that Orion5x does not have gatable clocks, so this core clock
> driver is sufficient to support clocking on Orion5x platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   8 +
>  drivers/clk/mvebu/Kconfig                          |   4 +
>  drivers/clk/mvebu/Makefile                         |   1 +
>  drivers/clk/mvebu/orion.c                          | 210 +++++++++++++++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 drivers/clk/mvebu/orion.c

Applied to mvebu/drivers-clk for routing through Mike's tree.  With
Sebastian's Ack.

thx,

Jason.
