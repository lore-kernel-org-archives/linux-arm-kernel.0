From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Oct 2017 10:45:34 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx6q-novena: Use the 'vpcie-supply'
 property
In-Reply-To: <1508100838-13406-1-git-send-email-festevam@gmail.com>
References: <1508100838-13406-1-git-send-email-festevam@gmail.com>
Message-ID: <20171018024532.GG18810@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 15, 2017 at 06:53:57PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Since commit c26ebe98a103 ("PCI: imx6: Add regulator support"), it is
> possible to pass the 'vpcie-supply' property to describe the PCIE supply.
> 
> This way we can remove the 'regulator-always-on' property from the
> regulator and have a better device tree description.
> 
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
