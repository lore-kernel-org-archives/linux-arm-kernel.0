From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Aug 2012 04:45:56 +0800
Subject: [PATCH V3] ARM: mxs: Update DENX M28 machine and dts file
In-Reply-To: <1345985971-12061-1-git-send-email-marex@denx.de>
References: <1345985971-12061-1-git-send-email-marex@denx.de>
Message-ID: <20120827204554.GA2281@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 02:59:31PM +0200, Marek Vasut wrote:
> Update the mach-mxs machine by removing the enet_clkout(). The new
> revision of the board doesn't need that. Also, update the DTS file
> with all the new drivers pulled in the mainline recently, that is,
> SPI, LRADC, USB.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.
