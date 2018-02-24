From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 16:29:27 +0800
Subject: [RFC] ARM: dts: imx28-tx28: Pass the memory unit name
In-Reply-To: <1518882103-17137-1-git-send-email-festevam@gmail.com>
References: <1518882103-17137-1-git-send-email-festevam@gmail.com>
Message-ID: <20180224082926.GJ3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 01:41:43PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass the memory unit name in order to fix the following
> dtc warning with W=1:
> 
> arch/arm/boot/dts/imx28-tx28.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
