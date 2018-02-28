From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Feb 2018 15:37:27 -0800
Subject: [GIT PULL 2/2] bcm2835-defconfig-next-2018-02-28
In-Reply-To: <20180228213945.6781-2-eric@anholt.net>
References: <20180228213945.6781-1-eric@anholt.net>
 <20180228213945.6781-2-eric@anholt.net>
Message-ID: <cf9c863a-8523-00da-4399-d4be641ad96d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2018 01:39 PM, Eric Anholt wrote:
> Hi Florian,
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-02-28
> 
> for you to fetch changes up to bb9d91a4e5c87cabfa2c9d35761374aa11150c2d:
> 
>   ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3 (2018-02-26 15:30:43 -0800)
> 
> ----------------------------------------------------------------
> This pull request enables several recent drivers for the Raspberry Pi
> family in the defconfigs (thermal, BT, aux serial).
> 
> ----------------------------------------------------------------
> Stefan Wahren (2):
>       ARM: bcm2385_defconfig: Enable BT support for BCM43438
>       ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3
> 
> Tuomas Tynkkynen (1):
>       ARM: multi_v7_defconfig: Enable serial console on RPi 3

Merged into defconfig/next, thanks Eric.
-- 
Florian
