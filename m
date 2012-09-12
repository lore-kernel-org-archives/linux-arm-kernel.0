From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 09:01:26 +0000
Subject: [PATCH V3 1/5] ARM: add infra-structure for BCM2708/BCM2835 and
 Raspberry Pi
In-Reply-To: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209120901.26990.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
> series which contains the BCM2835 amongst other variants. This patch
> adds very basic support for this series of SoCs, under the BCM2708 name.
> 
> http://www.broadcom.com/products/BCM2835
> http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pd
> 
> Note that the documentation in the latter .pdf assumes the MMU setup
> that's used on the "VideoCore" companion processor, and does not document
> physical peripheral addresses. Subtract 0x5e000000 to obtain the physical
> addresses.
> 
> The BCM2835 SoC is used in the Raspberry Pi. This patch also adds a
> minimal device tree for this board; enough to see some very early kernel
> boot messages through earlyprintk. However, this patch does not yet
> provide a useful booting system.
> 
> http://www.raspberrypi.org/.
> 
> This patch was extracted from git://github.com/lp0/linux.git branch
> rpi-split from 3-4 months ago, and significantly stripped down and
> modified since.
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <dc4@broadcom.com>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
