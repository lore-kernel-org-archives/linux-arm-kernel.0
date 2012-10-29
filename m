From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Oct 2012 07:59:46 +0000
Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
In-Reply-To: <94010fc0a0094ef29dc87fbdb77507e379c5fe76.1351466765.git.josh.cartwright@ni.com>
References: <cover.1351466765.git.josh.cartwright@ni.com>
 <94010fc0a0094ef29dc87fbdb77507e379c5fe76.1351466765.git.josh.cartwright@ni.com>
Message-ID: <4dc73182-4ae3-478e-9306-dbe1ff888388@VA3EHSMHS008.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Thursday, October 18, 2012 2:47 AM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
> 
> The Zynq uses the cortex-a9-gic.  This eliminates the need to hardcode register
> addresses.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/zynq-ep107.dts           | 10 ++++++----
>  arch/arm/mach-zynq/common.c                |  7 ++++++-
>  arch/arm/mach-zynq/include/mach/zynq_soc.h |  2 --
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 

Applied to http://git.xilinx.com/?p=linux-xlnx.git;a=shortlog;h=refs/heads/arm-next

Thanks,
Michal
