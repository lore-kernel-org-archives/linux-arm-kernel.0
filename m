From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 15:36:36 +0800
Subject: [PATCH] ARM: dts: imx: Remove skeleton.dtsi
In-Reply-To: <1478964635-12298-1-git-send-email-festevam@gmail.com>
References: <1478964635-12298-1-git-send-email-festevam@gmail.com>
Message-ID: <20161114073634.GN3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 01:30:35PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As explained by commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark
> skeleton.dtsi as deprecated"), including skeleton.dtsi is deprecated.
> 
> This fixes the following warning with W=1:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
