From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 7 Nov 2014 07:44:16 +0100
Subject: [PATCH] ARM: dts: zynq: Enable PL clocks for Parallella
In-Reply-To: <1415294531-8942-1-git-send-email-afaerber@suse.de>
References: <1415294531-8942-1-git-send-email-afaerber@suse.de>
Message-ID: <eca8ae5de8184151b03d3fd8d23c62a7@BY2FFO11FD010.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 06:22 PM, Andreas F?rber wrote:
> The Parallella board comes with a U-Boot bootloader that loads one of
> two predefined FPGA bitstreams before booting the kernel. Both define an
> AXI interface to the on-board Epiphany processor.
> 
> Enable clocks FCLK0..FCLK3 for the Programmable Logic by default.
> 
> Otherwise accessing, e.g., the ESYSRESET register freezes the board,
> as seen with the Epiphany SDK tools e-reset and e-hw-rev, using /dev/mem.
> 
> Cc: <stable@vger.kernel.org> # 3.17.x
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Michal/Olof, please consider this trivial patch as a fix for 3.18.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Olof, Arnd: Can you please pick this directly?

Thanks,
Michal
