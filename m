From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 May 2016 20:43:10 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Remove unneeded unit-addresses
In-Reply-To: <1461969585-17784-1-git-send-email-festevam@gmail.com>
References: <1461969585-17784-1-git-send-email-festevam@gmail.com>
Message-ID: <20160503124309.GI5874@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 07:39:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The following build warnings are seen when building with 'W=1' option:
> 
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-1p1 at 110 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-3p0 at 120 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-2p5 at 130 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-vddcore at 140 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-vddpu at 140 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-vddsoc at 140 has a unit name, but no reg property
> 
> Fix them by removing the unneeded unit-addresses.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
