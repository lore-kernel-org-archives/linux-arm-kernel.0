From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 5 Mar 2017 23:55:42 +0100
Subject: [PATCH] ARM: at91/dt: Disable SPI on at91sam9x5ek to allow MCI1
 to work.
In-Reply-To: <1487265388-29390-1-git-send-email-cristian.birsan@microchip.com>
References: <1487265388-29390-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <20170305225542.dptirws7djsrrlas@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The proper commit prefix was "ARM: dts: at91:"

On 16/02/2017 at 19:16:28 +0200, cristian.birsan at microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> The A13 hardware line is shared by SPI and MCI1 controller.This patch
> disables the SPI controller so that the MCI1 (the big MMC card slot) can
> be used.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  arch/arm/boot/dts/at91sam9x5ek.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
