From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 6 Jun 2016 16:19:05 +0800
Subject: [PATCH] ARM: dts: imx: Remove unneeded unit-addresses
In-Reply-To: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
References: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20160606081905.GB25018@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 10:57:31AM -0300, Fabio Estevam wrote:
> Building with W=1 option leads to several warnings like:
> 
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-1p1 at 110 has a unit name, but no reg property
> 
> Fix them by removing the unneeded unit-addresses.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
