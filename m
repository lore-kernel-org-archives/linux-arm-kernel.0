From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 15:12:52 -0800
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <566FDF53.3030004@sigmadesigns.com>
References: <566FDF53.3030004@sigmadesigns.com>
Message-ID: <20151222231252.GA19378@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:37:23AM +0100, Marc Gonzalez wrote:
> "One more time. We're gonna celebrate."
> 
> Changes since v10:
> Add aliases and chosen DT nodes
> Use CPU_CLK and SYS_CLK symbolic names
> MPCore private memory region DT node
> select TANGO_IRQ instead of GENERIC_IRQ_CHIP
> 
> Changes planned for a future patch series:
> Have clkgen driver export CD2 for USB, and CD6 for SDIO
> 
> Marc Gonzalez (2):
>   arm-soc: Import initial tango4 device tree
>   arm-soc: Add support for tango4 platforms

Thanks, I've applied these now (but with slightly modified patch subjects), and
with Kevin's reviewed-by tag:

ARM: dts: tango4: Initial device trees
ARM: tango4: Initial platform support


-Olof
