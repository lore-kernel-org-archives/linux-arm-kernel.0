From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Dec 2017 10:53:03 +0800
Subject: [PATCH] ARM: dts: imx7s: Avoid using label in unit address and reg
In-Reply-To: <1514318385-12135-1-git-send-email-festevam@gmail.com>
References: <1514318385-12135-1-git-send-email-festevam@gmail.com>
Message-ID: <20171227025302.GB23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 05:59:45PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As recommended by Rob Herring [1] labels should not be used in unit address
> and reg, so use its real value directly instead.
> 
> [1] https://www.spinics.net/lists/devicetree/msg206567.html
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
