From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 10:58:45 -0800
Subject: [PATCH] arm: zynq: Add missing irqchip.h to common.c
In-Reply-To: <1359376250-18841-1-git-send-email-michal.simek@xilinx.com>
References: <1359376250-18841-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <20130129185845.GA20184@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:50PM +0100, Michal Simek wrote:
> The patch: "ARM: use common irqchip_init for GIC init"
> (sha1: 0529e315bbda5d502c93df2cfafba9bb337fbdf4)
> should also add linux/irqchip.h header.
> 
> Error message:
> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init'
>   undeclared here (not in a function)
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied.


-Olof
