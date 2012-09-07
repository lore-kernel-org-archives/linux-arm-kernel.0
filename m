From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 7 Sep 2012 13:07:53 +0800
Subject: mxs: mmc: Problems resetting first SSP/MMC module upon boot
In-Reply-To: <EE31261C-7324-4E13-9EE0-D3BFB4C92B99@turczak.de>
References: <FDB97EE7-CE8F-4B83-A384-2E256DADCEDA@turczak.de>
 <20120907010143.GD26709@S2101-09.ap.freescale.net>
 <EE31261C-7324-4E13-9EE0-D3BFB4C92B99@turczak.de>
Message-ID: <20120907050750.GK26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 05:35:18AM +0200, Peter Turczak wrote:
> Exactly. Now after some testing I found out, any mmc[012] initialized first does not work. Everytime it's stmp_reset_block() fails for the respective block, which is strange.
> 
> When the bootloader (both ROM and u-boot from NAND) have initialized the slot before, smtp_reset_block() works and all mmc are available and working reliably.
> 
What bootloader are you using?  Mainline U-Boot or FSL one?

-- 
Regards,
Shawn
