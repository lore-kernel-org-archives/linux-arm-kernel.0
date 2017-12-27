From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Dec 2017 10:37:59 +0800
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard2: Remove leading zero in
 unit address
In-Reply-To: <1514310958-3792-1-git-send-email-festevam@gmail.com>
References: <1514310958-3792-1-git-send-email-festevam@gmail.com>
Message-ID: <20171227023759.GY23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 03:55:58PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove the leading zero from unit address to fix the following build
> warning with W=1:
> 
> arch/arm/boot/dts/imx6dl-hummingboard2.dtb: Warning (unit_address_format): Node /soc/aips-bus at 2100000/i2c at 21a0000/codec at 0a unit name should not have leading 0s
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
