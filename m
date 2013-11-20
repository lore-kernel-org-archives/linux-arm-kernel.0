From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 16:37:36 +0100
Subject: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201311201637.36733.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Stephen Warren wrote:
> This series implements a common reset framework driver for Tegra, and
> updates all relevant Tegra drivers to use it. It also removes the custom
> DMA bindings and replaced them with the standard DMA DT bindings.

The series is rather long, so I may have missed it, but I think you need one
more patch to the apbdma binding to document the use of #dma-cells, what
value it has, and what the format of the dma specifiers in slave drivers
needs to be.

	Arnd
