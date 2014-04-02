From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Apr 2014 17:09:02 +0800
Subject: [PATCH 1/2] ARM: dts: imx53-qsb-common: Fix memory region
 description
In-Reply-To: <1395983354-23196-1-git-send-email-festevam@gmail.com>
References: <1395983354-23196-1-git-send-email-festevam@gmail.com>
Message-ID: <20140402090901.GF8753@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 02:09:13AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> On mx53qsb there are two DRAM chip selects:
> 
> CS0 at 0x70000000
> CS1 at 0xb0000000
> 
> Each bank has a 512MB DRAM, giving a total of 1GB of system DRAM.
> 
> Fix the memory layout to describe the hardware appropriately.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thanks.
