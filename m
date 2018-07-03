From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 16:15:46 -0600
Subject: [PATCH V2 1/5] dt-bindings: arm: ti: Add bindings for AM654 SoC
In-Reply-To: <20180626162615.19194-2-nm@ti.com>
References: <20180626162615.19194-1-nm@ti.com>
 <20180626162615.19194-2-nm@ti.com>
Message-ID: <20180703221546.GA12606@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 11:26:11AM -0500, Nishanth Menon wrote:
> The AM654 SoC is a lead device of the K3 Multicore SoC architecture
> platform, targeted for broad market and industrial control with aim to
> meet the complex processing needs of modern embedded products.
> 
> Some highlights of this SoC are:
> * Quad ARMv8 A53 cores split over two clusters
> * GICv3 compliant GIC500
> * Configurable L3 Cache and IO-coherent architecture
> * Dual lock-step capable R5F uC for safety-critical applications
> * High data throughput capable distributed DMA architecture under NAVSS
> * Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>   PRUs and dual RTUs
> * Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
> * Centralized System Controller for Security, Power, and Resource
>   management.
> * Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
> * Flash subsystem with OSPI and Hyperbus interfaces
> * Multimedia capability with CAL, DSS7-UL, SGX544, McASP
> * Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
>   GPIO
> 
> See AM65x Technical Reference Manual (SPRUID7, April 2018)
> for further details: http://www.ti.com/lit/pdf/spruid7
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
>  * Picked up Tony's reviewed-by
>  
> V1: https://patchwork.kernel.org/patch/10475327/
> previous RFC: https://patchwork.kernel.org/patch/10447643/
> 
>  Documentation/devicetree/bindings/arm/ti/k3.txt | 23 +++++++++++++++++++++++
>  MAINTAINERS                                     |  7 +++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt

Reviewed-by: Rob Herring <robh@kernel.org>
