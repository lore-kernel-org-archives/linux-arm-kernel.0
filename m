From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 11 Jul 2018 20:32:29 +0800
Subject: [PATCH] ARM: dts: imx: Remove optional 'fsl,sec-era' property
In-Reply-To: <1530726770-814-1-git-send-email-festevam@gmail.com>
References: <1530726770-814-1-git-send-email-festevam@gmail.com>
Message-ID: <20180711123228.GE6959@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 02:52:50PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Since commit 654f2b937b38 ("crypto: caam - allow retrieving 'era' from
> register") the CAAM driver is capable of obtaining the era version by
> reading the appropriate CAAM registers, so let the CAAM driver discover
> the era version in run-time instead of hardcoding such information in the
> device tree.
> 
> According to Documentation/devicetree/bindings/crypto/fsl-sec4.txt the
> 'fsl,sec-era' is an optional property and this can be safely removed
> now.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
