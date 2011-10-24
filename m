From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Oct 2011 09:44:55 -0500
Subject: [PATCH V3 1/2] ARM: at91: dt: at91sam9g45 family and board device
	tree files
In-Reply-To: <15ab652499e7f6f8a26724bfd90643a8f3f96ad9.1319464310.git.nicolas.ferre@atmel.com>
References: <4E9F8226.4030503@gmail.com>
	<15ab652499e7f6f8a26724bfd90643a8f3f96ad9.1319464310.git.nicolas.ferre@atmel.com>
Message-ID: <4EA579E7.7000002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2011 09:05 AM, Nicolas Ferre wrote:
> Create a new device tree source file for Atmel at91sam9g45 SoC family.
> The Evaluation Kit at91sam9m10g45ek includes it.
> This first basic support will be populated as drivers and boards will be
> converted to device tree.
> Contains serial, dma and interrupt controllers.
> 
> The generic board file still takes advantage of platform data for early serial
> init. As we need a storage media and the NAND flash driver is not converted to
> DT yet, we keep old initialization for it.
> 

This comment is out of date for serial.

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> V3:
> - additional clock lookup for device tree handling
> - devices disabled in dtsi file so that only useful devices are
>   enabled in dts files
> 
> V2: foundation for AT91SAM generic support
> - device tree focused board file
> - inclusion of USART DT support
> - early USART and NAND still using platform data
> 

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Rob
