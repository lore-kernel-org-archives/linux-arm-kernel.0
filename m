From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Jan 2018 15:07:47 +0100
Subject: [PATCH v2 5/5] pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver
 for i.MX 6ULL
In-Reply-To: <20180106142553.15322-6-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
 <20180106142553.15322-6-stefan@agner.ch>
Message-ID: <CACRpkdYJcS3Ng=uR-iPgJ22ABfbiVENjWGsaWwShUfbg1hU4+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 6, 2018 at 3:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> From: Bai Ping <ping.bai@nxp.com>
>
> On i.MX 6ULL, the BOOT_MODEx and TAMPERx pin MUX and CTRL registers
> are available in a separate IOMUXC_SNVS module. Add support for the
> IOMUXC_SNVS module to the i.MX 6UL pinctrl driver.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied.

I need clear maintainership for Freescale pin controllers.

Stefan, would you consider making a patch adding you, Dong
Aisheng and Shawn Guo as maintainers in
MAINTAINERS for
drivers/pinctrl/freescale/*
Documentation/devicetree/bindings/pinctrl/fsl,*
?

I don't know if Shawn want to be added, but he wrote the first
version so unless he says explicitly no I think he should be
included.

Sascha, do you also wanna be included?

Yours,
Linus Walleij
