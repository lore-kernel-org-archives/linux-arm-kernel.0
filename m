From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 5 May 2017 14:13:54 +0200
Subject: [PATCH v5 00/20] net-next: stmmac: add dwmac-sun8i ethernet driver
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170505121354.GA14023@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 01, 2017 at 02:45:00PM +0200, Corentin Labbe wrote:
> Hello
> 
> This patch series add the driver for dwmac-sun8i which handle the Ethernet MAC
> present on Allwinner H3/H5/A83T/A64 SoCs.
> 
> This driver is the continuation of the sun8i-emac driver.
> During the development, it appeared that in fact the hardware was a modified
> version of some dwmac.
> So the driver is now written as a glue driver for stmmac.
> 
> It supports 10/100/1000 Mbit/s speed with half/full duplex.
> It can use an internal PHY (MII 10/100) or an external PHY
> via RGMII/RMII.
> 
> This patch series enable the driver only for the H3/A64/H5 SoC since A83T
> doesn't have the necessary clocks present in mainline.
> 
> The driver have been tested on the following boards:
> - H3 Orange PI PC, BananaPI-M2+
> - A64 Pine64, BananaPi-M64
> - A83T BananaPI-M3
> 
> The first two patchs are some mandatory changes for letting dwmac-sun8i be used.
> The following three patchs add the driver and its documentation.
> The remaining are DT patch enabling it.
> 
> Regards
> Corentin Labbe
> 

Hello Giuseppe

Since this serie have only one minor comment on documentation, could you give me your view about it ?

Regards
