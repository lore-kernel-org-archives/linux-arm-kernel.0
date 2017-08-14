From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Aug 2017 09:30:15 +0800
Subject: [PATCH 00/10] Add support for Ixora V1.1 and Apalis Evaluation
 Board
In-Reply-To: <cover.1502087184.git.maitysanchayan@gmail.com>
References: <cover.1502087184.git.maitysanchayan@gmail.com>
Message-ID: <20170814013014.GF31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 12:52:32PM +0530, Sanchayan Maity wrote:
> Hello,
> 
> This patch series adds support for Toradex Ixora V1.1 and Apalis
> Evaluation Board along with some cleanups.
> 
> Patch series has been generated on top of shawn's for-next branch.
> 
> Regards,
> Sanchayan.
> 
> Marcel Ziswiler (6):
>   ARM: dts: imx6q-apalis-ixora: combine aliases
>   ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: get rid of tegra legacy gen1_i2c comment
>   ARM: dts: imx6qdl-apalis: reword cam i2c comment
>   ARM: dts: imx6q-apalis-ixora: get rid of obsolete fusion comment
>   ARM: dts: imx6q-apalis-ixora: add camera i2c bus definition
>   ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: use i2c from dwc hdmi
> 
> Sanchayan Maity (4):
>   ARM: dts: imx6q-apalis-ixora: fix usdhc2 pinctrl property
>   ARM: dts: imx6qdl-apalis: split usdhc1 pinctrl to support 4- and 8-bit
>   ARM: dts: imx6: add support for Toradex Ixora V1.1 carrier board
>   ARM: dts: imx6q-apalis-eval: add support for Apalis Evaluation Board

Applied all, thanks.
