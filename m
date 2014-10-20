From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Oct 2014 15:34:05 +0100
Subject: [PATCH v6 01/10] ARM: add mach-asm9260
In-Reply-To: <1413814203-8785-2-git-send-email-linux@rempel-privat.de>
References: <1413814203-8785-1-git-send-email-linux@rempel-privat.de>
 <1413814203-8785-2-git-send-email-linux@rempel-privat.de>
Message-ID: <20141020143405.GV27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 04:09:54PM +0200, Oleksij Rempel wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5918d40..87373da 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -968,6 +968,8 @@ source "arch/arm/mach-w90x900/Kconfig"
>  
>  source "arch/arm/mach-zynq/Kconfig"
>  
> +source "arch/arm/mach-asm9260/Kconfig"
> +

This is not a promising start.  Before this is:

# This is sorted alphabetically by mach-* pathname.  However, plat-*
# Kconfigs may be included either alphabetically (according to the
# plat- suffix) or along side the corresponding mach-* source.

Please conform, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
