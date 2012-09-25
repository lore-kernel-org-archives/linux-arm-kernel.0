From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 15:51:04 +0800
Subject: [PATCH 1/2] ARM: dts: imx23-olinuxino: Remove unneeded
 "default-on"
In-Reply-To: <1348541540-15641-1-git-send-email-festevam@gmail.com>
References: <1348541540-15641-1-git-send-email-festevam@gmail.com>
Message-ID: <20120925075102.GK27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 11:52:19PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The initial state of the gpio led can be set directly in "gpios" node.
> 
> Hence, linux,default-trigger can be removed.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued both for 3.8, thanks.
