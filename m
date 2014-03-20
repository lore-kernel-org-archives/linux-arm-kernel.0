From: monstr@monstr.eu (Michal Simek)
Date: Thu, 20 Mar 2014 12:43:06 +0100
Subject: [PATCH v3 0/9] tty: xuartps: Rebranding + DT documentation
In-Reply-To: <1394650983-24780-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1394650983-24780-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <532AD44A.90409@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 03/12/2014 08:02 PM, Soren Brinkmann wrote:
> Here is a fixed and extended v3. I picked up Michal's patches and
> incorporated them into the series. Those are the first two patches.
> The 'rebranding' patch is correspondingly extended to convert the new
> code as well.
> 
> The erroneously changed compatibility string has been reverted back to
> what it should be.
> 
> 	S?ren
> 
> Michal Simek (2):
>   tty: xuartps: Fix kernel-doc errors in the driver
>   tty: xuartps: Initialize ports according to aliases
> 
> Soren Brinkmann (7):
>   tty: xuartps: Clean up
>   tty: xuartps: Print warning in clock notifier
>   tty: xuartps: Refactor read-modify-writes
>   tty: xuartps: Don't write IRQ disable register to enable interrupts
>   tty: xuartps: Rebrand driver as Cadence UART
>   tty: cadence: Document DT binding
>   ARM: zynq: DT: Migrate UART to Cadence binding

I have done boot test and console is still there
that's why
Tested-by: Michal Simek <michal.simek@xilinx.com>

I think that 1/9 - 8/9 should go through your tree
and 9/9 should go through arm-soc because there could
be some conflicts in dtsi.

Can you please apply that patches and I will take the rest
through arm-soc tree?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
