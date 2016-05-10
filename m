From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 14:41:36 +0200
Subject: [PATCH] arm64: defconfig: Add Juno SATA controller
In-Reply-To: <1462441458-24387-1-git-send-email-andre.przywara@arm.com>
References: <1462441458-24387-1-git-send-email-andre.przywara@arm.com>
Message-ID: <3677482.6TVNGmYCjE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2016 10:44:18 Andre Przywara wrote:
> The ARM Juno (r1 and r2) boards feature a SATA controller soldered
> on the board and connected to the PCI bus.
> Add the respective driver to defconfig to get hard disks supported out
> of the box on the Junos.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

I've applied this directly, although I'd prefer to see patches like this
get routed through the platform (vexpress/juno here) maintainers, or
have an Ack from them.

	Arnd
