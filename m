From: horms@verge.net.au (Simon Horman)
Date: Tue, 8 May 2018 15:35:40 +0200
Subject: [PATCH v3 0/2] ARM: dts: renesas: Correct mask for GIC PPI
 interrupts
In-Reply-To: <1525699193-5589-1-git-send-email-geert+renesas@glider.be>
References: <1525699193-5589-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180508133540.rxzqxulzagmnz2kc@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 03:19:51PM +0200, Geert Uytterhoeven wrote:
>         Hi Simon, Magnus,
> 
> R-Car H2 and R-Mobile APE6 contain four Cortex-A15 and four Cortex-A7
> cores, hence the second interrupt specifier cell for Private Peripheral
> Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts
> can be delivered to all 8 processor cores.
> 
> This brings the predecessors of R-Car Gen3 in line with what we're doing
> on other big.LITTLE SoCs, like R-Car H3 and M3-W.

Thanks, applied.
