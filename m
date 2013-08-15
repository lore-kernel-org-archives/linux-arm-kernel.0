From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 Aug 2013 09:28:00 -0400
Subject: [PATCH v3 2/5] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <20130814221237.350904818@gmail.com>
References: <20130814221043.528864175@gmail.com>
 <20130814221237.350904818@gmail.com>
Message-ID: <20130815132800.GM13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Domenico,

On Thu, Aug 15, 2013 at 12:10:45AM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Platform infrastructure for the Broadcom BCM4760 based ARM11 SoCs.
> 
> v3:
> * dropped the idea of unconditionally build mach-bcm
> 
> v2:
> * clocks are now configured via DT
> * uart DT nodes have been renamed and hooked to the proper clock nodes
> * dropped unneeded config options
> * dropped misused initialization of system_rev
> * dropped unneeded early io mapping 
> * build rule of mach-bcm is moved to separated patch
> 
> v1:
> * initial release
> 
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm4760.txt |    8 ++
>  MAINTAINERS                                       |    7 ++
>  arch/arm/Makefile                                 |    1 +
>  arch/arm/boot/dts/Makefile                        |    1 +
>  arch/arm/boot/dts/bcm4760-catalina.dts            |   11 +++
>  arch/arm/boot/dts/bcm4760.dtsi                    |   71 +++++++++++++++++++++
>  arch/arm/configs/bcm4760_defconfig                |   76 ++++++++++++++++++++++
>  arch/arm/mach-bcm/Kconfig                         |    7 ++
>  arch/arm/mach-bcm/Makefile                        |    2 +
>  arch/arm/mach-bcm/bcm4760.c                       |   37 +++++++++++
>  10 files changed, 221 insertions(+)

Since I raised the original objection to the unconditional build,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
