From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jun 2012 12:07:06 +0000
Subject: [PATCH v2 00/23] ARM: LPC32xx specific updates for next
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <201206151207.07108.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012, Roland Stigge wrote:
> This patch set includes various updates for mach-lpc32xx, including DT binding
> for serial, and dts updates. A new reference board is supported (EA3250). The
> board support file phy3250.c is updated to become more general, useable for
> other boards also. There is still board specific stuff in it, though (some
> devicetree auxdata).
> 
> Further, clock updates, DMA support, MMC support and a defconfig update for
> LPC32xx is included.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> --
> Applies to v3.5-rc2
> 
> Changes since v1:
> * Don't use pointers to functions in dma init struct (Patch 4)
> * Adjusted DT property status: "disable" -> "disabled" (Patch 15)
> * defconfig: Added MTD_M25P80 (Patch 9)
> * Fixed USB PHY I2C address for EA3250 (Patch 6)
> * Added patches 16 through 23 by Alexandre Pereira da Silva
> 
> You can also pull from
> 
>   git://git.antcom.de/linux-2.6.git lpc32xx-next

It all looks good from my point of view, so I think we can pull it
for 3.6 if no other comments come.

	Arnd
