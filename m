From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 24 Dec 2016 10:47:24 -0200
Subject: [PATCH] ARM: dts: imx: remove obsoleted property fsl,
 spi-num-chipselects
In-Reply-To: <20161224054354.28289-1-vz@mleia.com>
References: <20161224054354.28289-1-vz@mleia.com>
Message-ID: <CAOMZO5Cx3-OXyGohKE=QwFYWaLCx33NSxMsWjn=wbL3CGF2pmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2016 at 3:43 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> Since commit b36581df7e78 ("spi: imx: Using existing properties for
> chipselects") the device tree property 'fsl,spi-num-chipselects' is
> unused and it is already marked as obsolete in device tree binding
> documentation. Remove the property from the existing DTS files to
> avoid its reoccurence on copying.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
