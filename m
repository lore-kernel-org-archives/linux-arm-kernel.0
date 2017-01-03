From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jan 2017 09:23:51 +0800
Subject: [PATCH] ARM: dts: imx: remove obsoleted property
 fsl,spi-num-chipselects
In-Reply-To: <20161224054354.28289-1-vz@mleia.com>
References: <20161224054354.28289-1-vz@mleia.com>
Message-ID: <20170103012350.GL20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2016 at 07:43:54AM +0200, Vladimir Zapolskiy wrote:
> Since commit b36581df7e78 ("spi: imx: Using existing properties for
> chipselects") the device tree property 'fsl,spi-num-chipselects' is
> unused and it is already marked as obsolete in device tree binding
> documentation. Remove the property from the existing DTS files to
> avoid its reoccurence on copying.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Applied, thanks.
