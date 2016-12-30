From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 08:52:40 +0800
Subject: [PATCH] ARM: dts: imx: Adjust CPU nodes
In-Reply-To: <1479309338-12803-1-git-send-email-fabio.estevam@nxp.com>
References: <1479309338-12803-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20161230005236.GC6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 01:15:38PM -0200, Fabio Estevam wrote:
> Make CPU nodes consistent throughout the i.MX dts files, which
> also matches the description from ePAPR spec.
> 
> This also fixes the following W=1 warning in some cases:
> 
> Warning (unit_address_vs_reg): Node /cpus/cpu at 0 has a unit name, but no reg property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
