From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 15:49:05 +0200
Subject: NXP LPC32xx DT Updates for v4.7
In-Reply-To: <57215540.7060706@mleia.com>
References: <57215540.7060706@mleia.com>
Message-ID: <5081718.tFEgkGbhtW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 03:11:44 Vladimir Zapolskiy wrote:
> NXP LPC32xx device tree updates for v4.7
> 
> This includes a few functional changes:
> * new representation of MIC, SIC1 and SIC2 interrupt controllers,
> * disabled by default SPI1, SPI2, SSP0 and SSP1 SPI controllers in
>   shared lpc32xx.dtsi file,
> * added clock sources for SPI1 and SPI2,
> * set default clock rate of HCLK PLL to main osc rate multiplied by 16.
> 
> Also there are some non-functional changes:
> * flatten board DTS files by exploiting device node labels,
> * add 'partitions' device node for NAND SLC / MTD OF,
> * correct Atmel vendor prefix to describe on board AT24 EEPROMs,
> * rename board DTS files by adding SoC name prefix.
> 
> Since now DTS files of LPC32xx boards match "^lpc32[2345]0-" pattern.
> 

Looks all good, pulled into next/dt, thanks!

	Arnd
