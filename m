From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 13 Oct 2017 11:37:45 +0800
Subject: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: Use the 'vpcie-supply'
 property
In-Reply-To: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
References: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20171013033744.GC8833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 10:56:08AM -0300, Fabio Estevam wrote:
> Since commit c26ebe98a103 ("PCI: imx6: Add regulator support"), it is
> possible to pass the 'vpcie-supply' property to describe the PCIE supply.
> 
> This way we can remove the 'regulator-always-on' property from the
> regulator and have a better device tree description.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
