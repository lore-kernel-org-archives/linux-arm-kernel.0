From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 26 Apr 2016 11:08:35 +0100
Subject: [PATCH v3 0/4] Enable configs for 96boards HiKey and general arm64
In-Reply-To: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
References: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <571F3E23.7040805@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

On 02/04/2016 12:47, Guodong Xu wrote:
> This patch enables a number of devices currently supported by the Hi6220
> and 96boards HiKey. These include
> a) Hi655x PMIC and regulator
> b) Hi6220 I2C, USB, MMC, mailbox, and hisi-reset
> c) CONFIG_PINCTRL_SINGLE, and CONFIG_LEDS_GPIO
> d) WLAN, TI WL1835
> 
> Also added general features (built as modules) in arm64:
>  - SPIDEV
>  - USB network adapters
> 
> v3:
>  - rebase to next-20160401
>  - Enabled configs for WLAN and TI WL1835.

Thanks!
Applied series to the hisilicon soc tree.
And the b) and c) are already in the mainline, so I just kept a) and d) there.

Best Regards,
Wei

> 
> v2:
>  - rebase to next-20160310, CONFIG_MMC_BLOCK_MINORS=16 is already in.
>  - set CONFIG_I2C_DESIGNWARE_PLATFORM to be build as module
>  - Enable general features (as modules) in arm64
> 
> Akira Tsukamoto (1):
>   arm64: defconfig: enable several common USB network adapters
> 
> Guodong Xu (3):
>   arm64: defconfig: Enable devices for Hi6220 and 96boards HiKey
>   arm64: defconfig: add CONFIG_SPI_SPIDEV as module
>   arm64: defconfig: enable configs for WLAN and TI WL1835 as modules
> 
>  arch/arm64/configs/defconfig | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
