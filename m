From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jan 2018 10:42:19 -0600
Subject: [PATCH] pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for i.MX
 6ULL
In-Reply-To: <20180102164059.14641-1-stefan@agner.ch>
References: <20180102164059.14641-1-stefan@agner.ch>
Message-ID: <20180105164219.ug5w4xrsxl7lwwag@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 05:40:59PM +0100, Stefan Agner wrote:
> From: Bai Ping <ping.bai@nxp.com>
> 
> On i.MX 6ULL, the BOOT_MODEx and TAMPERx pin MUX and CTRL registers
> are available in a separate IOMUXC_SNVS module. Add support for the
> IOMUXC_SNVS module to the i.MX 6UL pinctrl driver.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |  3 +-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/freescale/pinctrl-imx6ul.c         | 52 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 3 deletions(-)
