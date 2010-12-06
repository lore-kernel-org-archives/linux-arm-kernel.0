From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 6 Dec 2010 10:25:21 +0000
Subject: ARM: add initial support for Picochip picoXcell SoC
In-Reply-To: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20101206102521.GC2891@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 10:06:01AM +0000, Jamie Iles wrote:
> Hi,
> 
> This patch series adds support for the Picochip picoXcell series of
> femotcell SoC's. There are currently two device families - PC3X2 and
> PC3X3. Both include an ARM1176JZ-S, 100Mb Ethernet controller, 2xDMA
> controllers, eFuses, crypto offload engines and Picochip's array
> processor the picoArray. This patch series adds support for the base
> chip support including timers, gpio, pin muxing, clocks and pm and also
> the PC7302 development board that can take either PC3X2 or PC3X3 devices.
> 
> This patch series is based off of linux-next (next-20101122) and also requires
> the following patches:
> 
>     - 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2):
>     http://marc.info/?l=linux-serial&m=129043658715199&w=2
>     - debug-8250: add a 32 bit mode:
>     http://marc.info/?l=linux-arm-kernel&m=129044061221371&w=2
Does anyone have any comments on this patch series?

Thanks,

Jamie
