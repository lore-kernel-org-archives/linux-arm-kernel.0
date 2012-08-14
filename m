From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 14 Aug 2012 12:24:00 +0200
Subject: [PATCHv2 0/4] Add device tree data for omap5
In-Reply-To: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
References: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <502A2740.9000206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sourav,

On 08/13/2012 12:05 PM, Sourav Poddar wrote:
> The following patch series add i2c support for omap5.
> As well as enable I2C based devices like pressure and temperature
> through device tree. Also add onchip keypad dts data.

That series does not seems to apply on top of 3.6-rc1, what based did
you use?

Benoit


> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Sourav Poddar (4):
>   arm/dts: omap5-evm: Add I2C support
>   arm/dts: omap5-evm: Add tmp102 sensor support
>   arm/dts: omap5-evm: Add keypad data
>   arm/dts: omap5-evm: Add bmp085 sensor support
> 
>  arch/arm/boot/dts/omap5-evm.dts |   30 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 0 deletions(-)
> 
