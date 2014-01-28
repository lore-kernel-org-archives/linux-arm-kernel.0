From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 19:59:22 +0800
Subject: [PATCH V3] ARM: imx: add always-on clock array for i.mx6sl to
 maintain correct usecount
In-Reply-To: <1390374887-22833-1-git-send-email-b20788@freescale.com>
References: <1390374887-22833-1-git-send-email-b20788@freescale.com>
Message-ID: <20140128115920.GG20583@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 03:14:47PM +0800, Anson Huang wrote:
> IPG, ARM and MMDC's clock should be enabled during kernel boot up,
> so we need to maintain their usecount, otherwise, they may be
> disabled unexpectedly if their children's clock are turned off, and
> caused their parent PLLs also get disabled, which is incorrect.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
