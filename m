From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 12:39:40 -0700
Subject: [GIT PULL 3/4] bcm2835-dt-next-2017-06-12
In-Reply-To: <20170613174356.22426-3-eric@anholt.net>
References: <20170613174356.22426-1-eric@anholt.net>
 <20170613174356.22426-3-eric@anholt.net>
Message-ID: <c3d7b024-af02-e629-2c57-53a2a726b3e4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2017 10:43 AM, Eric Anholt wrote:
> The following changes since commit 1f8216e7f78c2e55b07117c77887a314bc36f690:
> 
>   Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/next (2017-05-13 20:22:59 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2017-06-12
> 
> for you to fetch changes up to 9c53535a15b63218204f2bab2c279b3e64c61c0e:
> 
>   ARM: dts: bcm2835-rpi-zero: Enable OTG mode (2017-06-12 13:28:50 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in installation of the RPi3 DT in 32-bit
> mode, the new thermal nodes, switches to the faster sdhost controller
> for MMC, and enables USB OTG mode on the Pi 0.
> 
> ----------------------------------------------------------------
> Eric Anholt (1):
>       ARM: dts: Add devicetree for the Raspberry Pi 3, for arm32 (v6)
> 
> Gerd Hoffmann (1):
>       ARM: dts: bcm283x: switch from &sdhci to &sdhost
> 
> Stefan Wahren (4):
>       ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
>       ARM: dts: bcm283x: Add dtsi for OTG mode
>       ARM: dts: bcm283x: Add generic USB PHY
>       ARM: dts: bcm2835-rpi-zero: Enable OTG mode

Merged, thanks Eric!
-- 
-- 
Florian
