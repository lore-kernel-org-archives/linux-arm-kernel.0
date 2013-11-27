From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 12:13:41 +0100
Subject: [PATCH 00/04] ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL
 support
In-Reply-To: <20131127082736.20015.21303.sendpatchset@w520>
References: <20131127082736.20015.21303.sendpatchset@w520>
Message-ID: <8827692.Lf3xZYpHdb@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patches.

Looking at how the PFC and GPIO registers are interleaved I'll really need the 
datasheet to properly review this and the previous PFC and GPIO patches.

On Wednesday 27 November 2013 17:27:36 Magnus Damm wrote:
> ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL support
> 
> [PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device nodes
> [PATCH 02/04] ARM: shmobile: Genmai LED1 and LED2 support
> [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
> [PATCH 04/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration
> 
> Add various device nodes to the r7s72100 SoC and the Genmai board,
> nothing special just basic support for LEDs and I2C-over-GPIO.
> 
> Patch 4/4 depends on the r7s72100 PINCTRL pin grouping, but 1-3
> depends on the GPIO driver.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git tag renesas-devel-v3.13-rc1-20131125 and
>  [PATCH] pinctrl: sh-pfc: Initial r7s72100 support
>  [PATCH v3] gpio: Renesas RZ GPIO driver V3
> 
>  The following patches are needed for 4/4:
>  [PATCH 00/03] pinctrl: sh-pfc: r7s72100 SCIF2 support
>  [PATCH 01/03] pinctrl: sh-pfc: r7s72100 SCIF2 port3 support
>  [PATCH 02/03] pinctrl: sh-pfc: r7s72100 SCIF2 macro conversion
>  [PATCH 03/03] pinctrl: sh-pfc: r7s72100 SCIF2 port4, 6 and 8 support
> 
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   41 +++++-
>  arch/arm/boot/dts/r7s72100.dtsi                 |  154
> +++++++++++++++++++++++ 2 files changed, 194 insertions(+), 1 deletion(-)
-- 
Regards,

Laurent Pinchart
