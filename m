From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 21 Apr 2016 05:07:43 +0300
Subject: [PATCH v2 0/3] ARM: dts: lpc32xx: update ssp / spi nodes
In-Reply-To: <1461158460-2946-1-git-send-email-slemieux.tyco@gmail.com>
References: <1461158460-2946-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <571835EF.8040309@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 20.04.2016 16:20, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> This patchset change the following:
> 1) adds clock properties to spi peripheral devices,
>    clock ids are taken from dt-bindings/clock/lpc32xx-clock.h.
> 
> 2) enable SSP0 used by PHY3250.
>    preparatory change prior to disabling SSPx controllers.
> 
> 3) disable, by default, the SSP0/SPI1 and SSP1/SPI2 shared pinout;
>    shared pin should be enable in board specific dts, as needed.
> ---
> Changes from v1 to v2:
> * Update the patch as per the feedback received from:
>   Arnd: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/493250
>   - Start subject with "ARM" instead of "arm".
>   - Add a multi-line description for trivial patches.
>   Vladimir: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/493323
>             http://permalink.gmane.org/gmane.linux.ports.arm.kernel/493324
>   - Remove "clock-names" property.
>   - Switch patch #2 and #3 order.
> * Rebased on the following patch:
>   http://permalink.gmane.org/gmane.linux.drivers.devicetree/164584/
> 
> Sylvain Lemieux (3):
>   ARM: dts: lpc32xx: add clock properties to spi nodes
>   ARM: dts: phy3250: enable ssp0
>   ARM: dts: lpc32xx: disabled ssp0/spi1 & ssp1/spi2 by default
> 
>  arch/arm/boot/dts/lpc32xx.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/phy3250.dts  |  1 +
>  2 files changed, 15 insertions(+)
> 

all changes in the series are good from my point of view, I'll apply
them shortly.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
