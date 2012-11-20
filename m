From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 20 Nov 2012 13:41:42 +0100
Subject: [PATCH 2/3] ARM: zynq: make use of debug_ll_io_init()
In-Reply-To: <8aa73cfc61db3e516713e31a79ed38b03cf77e96.1353349191.git.josh.cartwright@ni.com>
References: <cover.1353349191.git.josh.cartwright@ni.com>
 <8aa73cfc61db3e516713e31a79ed38b03cf77e96.1353349191.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3dJEER5T1eXbkQNF_z627Ooco1aLeNUTKYv69AD6xAiCrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/19 Josh Cartwright <josh.cartwright@ni.com>:
> Convert low-level debugging routines to make use of debug_ll_io_init().
> This is part of the preparation for ARCH_MULTIPLATFORM support for Zynq.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/Kconfig.debug                             |  1 +
>  .../mach/debug-macro.S => include/debug/zynq.S}    |  3 +--
>  arch/arm/mach-zynq/common.c                        | 25 ++++++----------------
>  3 files changed, 9 insertions(+), 20 deletions(-)
>  rename arch/arm/{mach-zynq/include/mach/debug-macro.S => include/debug/zynq.S} (94%)

Tested-by: Michal Simek <michal.simek@xilinx.com>

Applied to xilinx arm-next branch.

Thanks,
Michal
