From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 15:56:36 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx23-sansa: Remove 'enable-active-low'
 property
In-Reply-To: <1495553564-19112-1-git-send-email-fabio.estevam@nxp.com>
References: <1495553564-19112-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170525075334.GA26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 12:32:43PM -0300, Fabio Estevam wrote:
> Property 'enable-active-low' does not exist. Only 'enable-active-high' is
> valid, and when this property is absent the gpio regulator will act as
> active low by default.
> 
> So remove the unexisting 'enable-active-low' property. 
> 
> Currently the GPIO flag is 0, which means active-high. In order to make
> the dts description accurate, pass the GPIO_ACTIVE_LOW flag instead.
> 
> This change is safe because the gpio regulator driver does not take the
> GPIO flag polarity into account.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
