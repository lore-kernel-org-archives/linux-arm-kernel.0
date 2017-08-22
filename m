From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Aug 2017 22:20:54 +0200
Subject: [PATCH 3/3] ARM: dts: sun7i: Rename sun7i-a20-olinuxino-lime2-emmc
In-Reply-To: <20170822114313.9038-4-stefan@olimex.com>
References: <20170822114313.9038-1-stefan@olimex.com>
 <20170822114313.9038-4-stefan@olimex.com>
Message-ID: <20170822202054.hpyl3ndo3apduone@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 22, 2017 at 02:43:13PM +0300, Stefan Mavrodiev wrote:
> Rename dts file for A20-OLinuXino-LIME2-eMMC to match Olimex Ltd.
> naming convention.
> 
> <board-name>-exGB - option with <x>GB eMMC chip
> <board-name>-nxGB - option with <x>GB NAND chip
> <board-name>-sxMB - option with <x>MB SPI FLASH chip
> 
> For example:
> 	A20-OLinuXino-LIME2-e4GB - 4GB eMMC
> 	A20-OLinuXIno-LIME2-n4GB - 4GB NAND
> 	A20-OLinuXIno-LIME2-n8GB - 8GB NAND

I'm not going to merge this patch, because it basically breaks all the
bootloaders scripts, distros or build systems out there. We have a
name, let's stick with that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/36327da5/attachment.sig>
