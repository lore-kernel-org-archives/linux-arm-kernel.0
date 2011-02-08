From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 8 Feb 2011 14:52:15 +0000
Subject: [PATCHv4 00/13] ARM: add initial support for Picochip picoXcell
	SoC
In-Reply-To: <1296648212-5284-1-git-send-email-jamie@jamieiles.com>
References: <1296648212-5284-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110208145215.GB8679@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 12:03:19PM +0000, Jamie Iles wrote:
> Hi,
> 
> This patch series adds support for the Picochip picoXcell series of
> femtocell SoC's. There are currently two device families - PC3X2 and
> PC3X3. Both include an ARM1176JZ-S, 100Mb Ethernet controller, 2xDMA
> controllers, eFuses, crypto offload engines and Picochip's array
> processor the picoArray. This patch series adds support for the base
> chip support including timers, gpio, pin muxing, clocks and pm and also
> the PC7302 development board that can take either PC3X2 or PC3X3 devices.
> 
>     - debug-8250: add a 32 bit mode:
>     http://marc.info/?l=linux-arm-kernel&m=129044061221371&w=2
> 
> Changes since v3 include:
> 
> 	- Move to fixed sched_clock() implementation.
> 	- Remove excessive use of __init directives.
> 	- Simplify pm to allow drivers to manage all clks.
> 
> This also picks up on the CPU_V6K and PLAT_PHYS_OFFSET changes.  I've
> also removed the SRAM patch to try and just get the core support in and
> make it simpler for review.

ping.  Anyone have any feedback on these patches or anything to make 
them easier to review?

Thanks,

Jamie
