From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 15:43:35 -0600
Subject: [PATCH V3 09/11] clk: sprd: add clocks support for SC9860
In-Reply-To: <20171102065626.21835-10-chunyan.zhang@spreadtrum.com>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
 <20171102065626.21835-10-chunyan.zhang@spreadtrum.com>
Message-ID: <20171106214335.qvuvcwahemnpwftt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 02:56:24PM +0800, Chunyan Zhang wrote:
> This patch added the list of clocks for Spreadtrum's SC9860 SoC,
> together with clock initialization code.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  drivers/clk/sprd/Kconfig                    |   10 +
>  drivers/clk/sprd/Makefile                   |    3 +
>  drivers/clk/sprd/sc9860-clk.c               | 1987 +++++++++++++++++++++++++++
>  include/dt-bindings/clock/sprd,sc9860-clk.h |  408 ++++++

This belongs in the binding doc patch.

Rob
