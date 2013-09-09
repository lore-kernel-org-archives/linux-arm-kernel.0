From: trini@ti.com (Tom Rini)
Date: Mon, 9 Sep 2013 09:19:02 -0400
Subject: [PATCHv3] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
In-Reply-To: <1378638746-10627-1-git-send-email-koen@dominion.thruhere.net>
References: <1378638746-10627-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <522DCAC6.8080705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2013 07:12 AM, Koen Kooi wrote:
> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
> 
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver 
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8. 
> 
> MMC support for AM335x still isn't in, so only the LDO change has been added.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>

Grabbed my beaglebone white and black and tested them both on top of
e5c832d (top of Linus' tree atm), came up with a ramdisk.

Tested-by: Tom Rini <trini@ti.com>

-- 
Tom
