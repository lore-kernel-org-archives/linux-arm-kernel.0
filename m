From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 7 Aug 2017 10:47:23 -0700
Subject: [GIT PULL 2/2] bcm2835-defconfig-next-2017-08-07
In-Reply-To: <20170807163531.2940-2-eric@anholt.net>
References: <20170807163531.2940-1-eric@anholt.net>
 <20170807163531.2940-2-eric@anholt.net>
Message-ID: <8f84d891-8bb1-1a79-645f-218763d798dd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2017 09:35 AM, Eric Anholt wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> 
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2017-08-07
> 
> for you to fetch changes up to 6235a80a5475d10ebef646c06cf7cf0f4aba688c:
> 
>   ARM: bcm2835_defconfig: Enable wifi driver for RPi Zero W (2017-07-19 13:37:34 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in defconfig changes for the Raspberry Pi
> Zero W.
> 
> ----------------------------------------------------------------
> Stefan Wahren (3):
>       ARM: bcm2835_defconfig: Enable Mini UART console support
>       ARM: bcm2835_defconfig: Increase CMA for VC4
>       ARM: bcm2835_defconfig: Enable wifi driver for RPi Zero W

Also merged, thanks Eric!

> 
>  arch/arm/configs/bcm2835_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 


-- 
Florian
