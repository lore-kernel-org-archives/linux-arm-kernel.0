From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 19:12:25 +0800
Subject: [PATCH] ARM: dts: imx6qdl-wandboard-revd1: Make EDID functional
In-Reply-To: <1510064971-18755-1-git-send-email-fabio.estevam@nxp.com>
References: <1510064971-18755-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20171116111224.GO25384@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 12:29:31PM -0200, Fabio Estevam wrote:
> There are 0 ohm resistors that allow selecting the EDID I2C port to
> be I2C1 or I2C2.
> 
> On revd1 the 0 ohm resistors are populated in such a way that the I2C2
> is used as DDC I2C bus, so fix it accordingly. 
> 
> Reported-by: Lu?s Mendes <luis.p.mendes@gmail.com>
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
