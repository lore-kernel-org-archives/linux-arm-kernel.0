From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Nov 2014 16:58:02 -0800
Subject: [PATCH] ARM: dts: zynq: Enable PL clocks for Parallella
In-Reply-To: <eca8ae5de8184151b03d3fd8d23c62a7@BY2FFO11FD010.protection.gbl>
References: <1415294531-8942-1-git-send-email-afaerber@suse.de>
 <eca8ae5de8184151b03d3fd8d23c62a7@BY2FFO11FD010.protection.gbl>
Message-ID: <20141109005802.GE13855@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 07:44:16AM +0100, Michal Simek wrote:
> On 11/06/2014 06:22 PM, Andreas F?rber wrote:
> > The Parallella board comes with a U-Boot bootloader that loads one of
> > two predefined FPGA bitstreams before booting the kernel. Both define an
> > AXI interface to the on-board Epiphany processor.
> > 
> > Enable clocks FCLK0..FCLK3 for the Programmable Logic by default.
> > 
> > Otherwise accessing, e.g., the ESYSRESET register freezes the board,
> > as seen with the Epiphany SDK tools e-reset and e-hw-rev, using /dev/mem.
> > 
> > Cc: <stable@vger.kernel.org> # 3.17.x
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > ---
> >  Michal/Olof, please consider this trivial patch as a fix for 3.18.
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> Olof, Arnd: Can you please pick this directly?

Done, applied to fixes.


-Olof
