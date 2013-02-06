From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 Feb 2013 14:16:54 +0100
Subject: [PATCH v2 0/4] ARM: mvebu: Add support for SPI flash devices
 in Armada 370/XP
In-Reply-To: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <511257C6.2070604@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 02:06 PM, Ezequiel Garcia wrote:
> This is second version of the SPI patchset for Armada 370/XP.
> 
> This series first adds support for the SPI controller
> and then adds the SPI flash for the Armada XP GP board.
> 
> This series is based on 3.8-rc5 plus:
>  * "arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"
>  * "arm: mvebu: i2c come back in defconfig"
> 
> Feel free to test or provide any feedback!
> 
Ezequiel,

I reviewed the patches, I have nothing more to say, I can add my:

Acked-by: Gregory Clement <gregory.clement@free-electrons.com>

on the patch that didn't have yet.

Jason,
could you add this series in your incoming pull request?

Thanks,

> Ezequiel Garcia (4):
>   arm: mvebu: Add support for SPI controller in Armada 370/XP
>   ARM: mvebu: Update defconfig to select SPI support
>   arm: mvebu: Add SPI flash on Armada XP-GP board
>   ARM: mvebu: Update defconfig to select SPI flash and MTD support
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-gp.dts   |   12 ++++++++++++
>  arch/arm/configs/mvebu_defconfig     |    5 +++++
>  3 files changed, 39 insertions(+), 0 deletions(-)
> 
> Thanks,
> 
>     Ezequiel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
