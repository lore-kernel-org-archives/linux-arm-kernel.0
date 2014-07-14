From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jul 2014 22:56:52 +0800
Subject: [PATCH 1/2] ARM: dts: add initial Rex Pro board support
In-Reply-To: <1404830963-18274-1-git-send-email-robertcnelson@gmail.com>
References: <1404830963-18274-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <20140714145650.GB2607@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:49:22AM -0500, Robert Nelson wrote:
> Add initial Rex Pro i.mx6q board support. Ethernet, UART, USB, I2C, SPI, HDMI,
> Audio, and SDHC cards are working.  Currently no mainline u-boot, so boot with
> cat zImage imx6q-rex-pro.dtb > zImage.dtb, then using mkimage create uImage
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

Applied both, thanks.
