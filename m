From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 31 Dec 2012 08:28:50 +0800
Subject: [PATCH] ARM: mach-imx: Kconfig: Do not select Babbage for
 MACH_IMX51_DT
In-Reply-To: <1356704747-14845-1-git-send-email-festevam@gmail.com>
References: <1356704747-14845-1-git-send-email-festevam@gmail.com>
Message-ID: <20121231002849.GB31816@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 12:25:47PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When mx51 dt support was added it was necessary to select MACH_MX51_BABBAGE in
> order to get the mx51 dt built without errors.
> 
> At that time, there was no pinctrl support for mx51 yet.
> 
> Currently there is no need to select MACH_MX51_BABBAGE anymore.
> 
> Reported-by: Matt Sealy <matt@genesi-usa.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
