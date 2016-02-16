From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 11:56:08 +0100
Subject: [PATCH v3 06/10] ARM: mps2: introduce MPS2 platform
In-Reply-To: <1455617295-23736-7-git-send-email-vladimir.murzin@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-7-git-send-email-vladimir.murzin@arm.com>
Message-ID: <29457600.xRDuy0uVjW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 10:08:11 Vladimir Murzin wrote:
> The Cortex-M Prototyping System (or V2M-MPS2) is designed for
> prototyping and evaluation Cortex-M family of processors including the
> latest Cortex-M7
> 
> It comes with a range of useful peripherals including 8MB single cycle
> SRAM, 16MB PSRAM, Ethernet, QSVGA touch screen panel, 4bit RGB VGA
> connector, Audio, SPI and GPIO.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/Kconfig                 |    8 ++++++++
>  arch/arm/Makefile                |    1 +
>  arch/arm/mach-mps2/Makefile      |    1 +
>  arch/arm/mach-mps2/Makefile.boot |    3 +++
>  arch/arm/mach-mps2/dtmachine.c   |   21 +++++++++++++++++++++
> 

We are in the (slow) process of consolidating the ARM reference platforms
(versatile, integrator, realview, vexpress) into one place.

I'd suggest adding all this to the mach-vexpress directory rather than
a new directory, so we don't have another one to consolidate.

	Arnd
