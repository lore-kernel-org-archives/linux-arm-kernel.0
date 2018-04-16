From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 15:08:20 +0800
Subject: [PATCH 1/2] ARM: dts: imx25-pdk: Remove unneeded 'codec-handle'
 property
In-Reply-To: <1521049176-22870-1-git-send-email-festevam@gmail.com>
References: <1521049176-22870-1-git-send-email-festevam@gmail.com>
Message-ID: <20180416070819.GA25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 02:39:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The 'codec-handle' property is an optional one and there is really
> no need to be used here.
> 
> As per the comment in the fsl_ssi driver:
> 
> "Backward compatible for older bindings by manually triggering the
> machine driver's probe()."
> 
> ,so just remove such uneeded property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
