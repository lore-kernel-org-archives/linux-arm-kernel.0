From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 May 2014 20:02:51 +0800
Subject: [PATCH v2] i.MX25 dts updates
In-Reply-To: <1399615879-30781-1-git-send-email-s.hauer@pengutronix.de>
References: <1399615879-30781-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140509120248.GG2870@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 08:11:13AM +0200, Sascha Hauer wrote:
> Changes since v1:
> 
> - Fix mmc1 alias name
> - Add enable-active-high to FEC phy regulator
> - Fix gpio number for FEC phy reset
> 
> Sascha
> 
> ----------------------------------------------------------------
> Sascha Hauer (6):
>       ARM: dts: i.MX25: Add mmc aliases
>       ARM: dts: i.MX25: remove disabled property of usbmisc unit

Applied all except this one.

Shawn

>       ARM: dts: i.MX25: Add IRAM node
>       ARM: dts: Karo TX25: Add pinctrl nodes
>       ARM: dts: Karo TX25: Add phy reset gpio and supply for FEC
>       ARM: dts: Karo TX25: use hardware ecc
> 
>  arch/arm/boot/dts/imx25-karo-tx25.dts | 73 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx25.dtsi          |  8 +++-
>  2 files changed, 80 insertions(+), 1 deletion(-)
