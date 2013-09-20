From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Sep 2013 17:01:53 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: SDHC ports are 8 bit-wide
In-Reply-To: <1379436383-29428-1-git-send-email-fabio.estevam@freescale.com>
References: <1379436383-29428-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130920090152.GC13620@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 01:46:23PM -0300, Fabio Estevam wrote:
> On imx6qdl-sabresd the SDHC2 and SDHC3 are 8 bit-wide, so pass the bus-width
> property to reflect that.
> 
> Otherwise the mmc driver will operate with the default bus-width value of 4.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
