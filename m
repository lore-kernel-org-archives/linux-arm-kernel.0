From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Sep 2016 10:31:09 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Fix SPDIF regression
In-Reply-To: <1472651808-28034-1-git-send-email-fabio.estevam@nxp.com>
References: <1472651808-28034-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20160905023109.GG25778@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 10:56:48AM -0300, Fabio Estevam wrote:
> Commit 833f2cbf7091 ("ARM: dts: imx6: change the core clock of spdif")
> changed many more clocks than only the SPDIF core clock as stated in
> the commit message.
> 
> The MLB clock has been added and this causes SPDIF regression as
> reported by Xavi Drudis Ferran and also in this forum post:
> https://forum.digikey.com/thread/34240
> 
> The MX6Q Reference Manual does not mention that MLB is a clock related
> to SPDIF, so change it back to a dummy clock to restore SPDIF
> functionality.
> 
> Thanks to Ambika for providing the fix at:
> https://community.nxp.com/thread/387131
> 
> Fixes: 833f2cbf7091 ("ARM: dts: imx6: change the core clock of spdif")
> Cc: <stable@vger.kernel.org> # 4.4.x
> Reported-by: Xavi Drudis Ferran <xdrudis@tinet.cat>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
