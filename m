From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Oct 2012 08:00:09 +0000
Subject: [PATCH v4 2/5] zynq: use pl310 device tree bindings
In-Reply-To: <a60818e7f2bf13cbc06b21bb3e3b0071539379ea.1351466765.git.josh.cartwright@ni.com>
References: <cover.1351466765.git.josh.cartwright@ni.com>
 <a60818e7f2bf13cbc06b21bb3e3b0071539379ea.1351466765.git.josh.cartwright@ni.com>
Message-ID: <d9c47e1e-a6c8-4f84-b086-e83b1ed62b4b@CO1EHSMHS010.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Wednesday, October 24, 2012 12:34 AM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 2/5] zynq: use pl310 device tree bindings
> 
> The Zynq has a PL310 L2 cache controller.  Convert in-tree uses to using the
> device tree.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-ep107.dts           | 9 +++++++++
>  arch/arm/mach-zynq/common.c                | 9 +--------
>  arch/arm/mach-zynq/include/mach/zynq_soc.h | 4 ----
>  3 files changed, 10 insertions(+), 12 deletions(-)

Applied to http://git.xilinx.com/?p=linux-xlnx.git;a=shortlog;h=refs/heads/arm-next

Thanks,
Michal
