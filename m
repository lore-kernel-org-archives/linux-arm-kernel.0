From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Feb 2018 15:35:49 -0800
Subject: [GIT PULL 1/2] bcm2835-dt-next-2018-02-28
In-Reply-To: <20180228213945.6781-1-eric@anholt.net>
References: <20180228213945.6781-1-eric@anholt.net>
Message-ID: <1c65dc88-901f-2ad7-0f45-5d2f53dc1048@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2018 01:39 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2018-02-28
> 
> for you to fetch changes up to bcc76c4014dce4e3834dbd5b7f6593cbcfbfebe0:
> 
>   ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode (2018-02-26 15:02:23 -0800)
> 
> ----------------------------------------------------------------
> This pull request adds automatic BT probing to the Pi Zero W, OTG mode
> for the Zero W, the GPIO expander on the Pi3, and fixes I2S probe
> (which is disabled by default, but often used downstream)
> 
> ----------------------------------------------------------------
> Baruch Siach (2):
>       ARM: dts: bcm2835: make the firmware node into a bus
>       ARM: dts: bcm2837-rpi-3-b: add GPIO expander
> 
> Henry Zhang (1):
>       ARM: dts: bcm283x: Fix pin function of JTAG pins
> 
> Stefan Wahren (5):
>       dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
>       ARM: dts: bcm283x: Fix probing of bcm2835-i2s
>       ARM: dts: bcm283x: Apply pull settings to Zero W relevant groups
>       ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
>       ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode

Merged into devicetree/next, thanks Eric!
-- 
Florian
