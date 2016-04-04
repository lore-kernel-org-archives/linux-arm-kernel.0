From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 4 Apr 2016 14:35:08 +0200
Subject: [PATCH v2] ARM: dts: orion5x: add device tree for kurobox-pro
In-Reply-To: <1459267905-15403-1-git-send-email-rogershimizu@gmail.com>
References: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
 <1459267905-15403-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160404123508.GF21828@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 01:11:45AM +0900, Roger Shimizu wrote:
> Add dts file to support Buffalo/Revogear Kurobox-Pro, which is marvell
> orion5x based 3.5" HDD NAS.
> 
> It's a quite old product and already discontinued. So there's no
> official website for it. But it was an early product which used marvell
> orion5x 88F5182 chipset, it's popular in the community.
> Some unofficial site:
>   - http://buffalo.nas-central.org/wiki/Category:KuroboxPro
>   - http://nice.kaze.com/KUROPRO_ProductSpecifications.pdf
> 
> This device tree is based on the board file:
>   arch/arm/mach-orion5x/kurobox_pro-setup.c
> However, the probing order of NAND and JEDEC-Flash are different from
> the original board file, this results in incompatible minor number
> for a few /dev/mtdX and /dev/mtdblockX devices.
> So I still want to keep the board file for the time being.
> 
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>

Hi Roger

Looks good:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	     Andrew
