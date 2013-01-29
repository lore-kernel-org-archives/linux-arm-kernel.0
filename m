From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 15:51:48 +0800
Subject: [PATCH 2/2] ARM: dts: cfa10049: Change the SPI3 bus to spi-gpio
In-Reply-To: <1359103175-26304-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1359103175-26304-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359103175-26304-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130129075146.GE21504@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 09:39:35AM +0100, Maxime Ripard wrote:
> The DAC found on the last chip select requires a word length of 12 bits,
> which is not supported by the SSP controller of the iMX28. Use
> bitbanging for that bus to support such a length.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.
