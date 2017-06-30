From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 30 Jun 2017 22:41:28 +0200
Subject: arm64: dts: rockchip: add SdioAudio pd control for rk3399
In-Reply-To: <1498802513-535-1-git-send-email-wxt@rock-chips.com>
References: <1498802513-535-1-git-send-email-wxt@rock-chips.com>
Message-ID: <4239199.7DEpkIs6Fd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Freitag, 30. Juni 2017, 14:01:53 CEST schrieb Caesar Wang:

subject was missing the "[PATCH]" prefix. While not necessary for applying,
having it makes it easier to find stuff in an inbox :-) .


> The SdioAudio power domain includes the i2s/spdif/spi5/sdio.
> 
> So this patch adds the pd control for rk3399 i2s/spdif/spi5/sdio, in order
> to save more power consumption.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
> Changes note:
> - As the Jeffy fixes the spi'cs issue recently as follows:
> aa09938 spi: rockchip: Disable Runtime PM when chip select is asserted
> c863795 spi: rockchip: Set GPIO_SS flag to enable Slave Select with GPIO CS
> c351587 spi: rockchip: fix error handling when probe

as these are in Mark's tree for 4.13, I've now applied your patch for 4.14
but moved the power-domains property for sdio and spi5 to a better sort
position.


Heiko
