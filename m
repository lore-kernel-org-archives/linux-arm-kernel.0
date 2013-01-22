From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Jan 2013 22:26:01 +0800
Subject: [PATCH] ARM: imx: Remove mx508 support
In-Reply-To: <1358858455-9600-1-git-send-email-fabio.estevam@freescale.com>
References: <1358858455-9600-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130122142559.GB4920@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:40:55AM -0200, Fabio Estevam wrote:
> Only mx508 based board is mach-mx50_rdp and it has been marked as BROKEN
> for several releases.
> 
> mx508 currently lacks clock support.
> 
> In case someone needs to add mx508 support back, then the recommended approach 
> is to use device tree.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
