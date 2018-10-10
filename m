From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:09:25 +0200
Subject: [PATCH 0/11] spi: pxa2xx: add DT and slave mode support
Message-ID: <20181010170936.316862-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

This patchset adds devicetree and slave mode support to pxa2xx SPI
controller. The objective is that it will be able to support the
OLPC XO 1.75 embedded controller that is a SPI master talking to a
MMP2 SOC. The EC driver will be submitted in a separate patch set
shortly.
 
These patches have been submitted previously, but not applied:

[PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
[PATCH v2 02/11] PCI: Provide pci_match_id() with CONFIG_PCI=n
[PATCH 03/11] spi: pxa2xx: Use an enum for type
[PATCH 04/11] spi: pxa2xx: Add devicetree support
[PATCH v2 05/11] DT: marvell,mmp2: Add SSP1 and SSP3

These are new:

[PATCH 06/11] dt-bindings: spi/spi-pxa2xx: Add spi-slave property
[PATCH 07/11] spi: Deal with slaves that return from transfer_one()
[PATCH 08/11] spi: pxa2xx: Add slave mode support
[PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
[PATCH 10/11] spi: pxa2xx: Add ready signal
[PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in TXFIFO

Verified on a OLPC XO 1.75 machine.

Thank you,
Lubo
