From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 13 Oct 2014 13:24:53 -0700
Subject: [PATCH 1/3] ARM: zynq: Move common.h to generic location
In-Reply-To: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
References: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
Message-ID: <072b20fe15464ebfb94ecbeba79afdd8@BY2FFO11FD022.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-06 at 01:44PM +0200, Michal Simek wrote:
> include/soc/zynq/ is the right location for this header
> to be able to share information from this header with other
> drivers which require it.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm/mach-zynq/common.c                       | 2 +-
>  arch/arm/mach-zynq/hotplug.c                      | 2 +-
>  arch/arm/mach-zynq/platsmp.c                      | 2 +-
>  arch/arm/mach-zynq/slcr.c                         | 2 +-

In the 3.18 merge window arch/arm/mach-zynq/pm.c had been added which is
not covered in this version of the patch.

	S?ren
