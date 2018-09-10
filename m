From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Sep 2018 09:09:14 +0800
Subject: [PATCH] ARM: dts: imx6q-apalis: mux RESET_MOCI# signal
In-Reply-To: <20180906234658.12205-1-stefan@agner.ch>
References: <20180906234658.12205-1-stefan@agner.ch>
Message-ID: <20180910010913.GD21992@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 04:46:58PM -0700, Stefan Agner wrote:
> The pinctrl properties on the IOMUXC node get overwritten by the
> carrier board level device tree, hence the pinctrl_reset_moci
> pinctrl does not get applied.
> 
> Associate the pinctrl_reset_moci pinctrl with the PCIe node where
> we also make use of the pin as a reset GPIO.
> 
> Since the pin is muxed as a GPIO by default not muxing it explicitly
> worked fine in practise.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
