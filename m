From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Mar 2014 06:13:13 +0100
Subject: [PATCH 2/2] ARM: dts: imx53-m53evk: Fix memory region description
In-Reply-To: <1395983354-23196-2-git-send-email-festevam@gmail.com>
References: <1395983354-23196-1-git-send-email-festevam@gmail.com>
 <1395983354-23196-2-git-send-email-festevam@gmail.com>
Message-ID: <201403280613.13798.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 28, 2014 at 06:09:14 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> On m53evk there are two DRAM chip selects:
> 
> CS0 at 0x70000000
> CS1 at 0xb0000000
> 
> Each bank has a 512MB DRAM, giving a total of 1GB of system DRAM.
> 
> Fix the memory layout to describe the hardware appropriately.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

Nice find Fabio, thanks!

Best regards,
Marek Vasut
