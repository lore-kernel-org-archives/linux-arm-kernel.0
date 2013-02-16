From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 13:52:53 -0500
Subject: [PATCH v3 3/3] arm: mvebu: enable gpio expander over i2c on
 Mirabox platform
In-Reply-To: <1358889025-8530-4-git-send-email-gregory.clement@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130216185253.GD23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:10:25PM +0100, Gregory CLEMENT wrote:
> The Globalscale Mirabox platform can be connected to the JTAG/GPIO box
> through the Multi-IO port. The GPIO box use the NXP PCA9505 I/O port
> expansion IC to provide 40-bit parallel input/output GPIOs. This patch
> enable the use of this expander on the Mirabox.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/armada-370-mirabox.dts |   10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied to mvebu/dt_deps with a dependency on gpio/for-next for:

      89f5df0 gpio: pca953x: add support for pca9505
      f5f0b7a gpio: pca953x: make the register access by GPIO bank

thx,

Jason.
