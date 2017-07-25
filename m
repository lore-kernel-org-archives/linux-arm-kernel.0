From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 16:16:38 +0800
Subject: [PATCH] ARM: dts: imx6qdl-gw5xxx: Remove the 'uart-has-rtscts'
 property
In-Reply-To: <1500123985-23754-1-git-send-email-festevam@gmail.com>
References: <1500123985-23754-1-git-send-email-festevam@gmail.com>
Message-ID: <20170725081637.GF20064@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 15, 2017 at 10:06:25AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The 'uart-has-rtscts' property should be used when the board exposes the
> native RTS and CTS UART pins.
> 
> On the imx6qdl-gw5xxx boards such pins are not used, so remove the
> 'uart-has-rtscts' property to make the hardware description correct.
> 
> Documentation/devicetree/bindings/serial/serial.txt states that
> 'uart-has-rtscts' and 'rts-gpios' properties are mutually exclusive.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
