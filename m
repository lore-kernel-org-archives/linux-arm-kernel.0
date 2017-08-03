From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 Aug 2017 09:53:13 +0800
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Remove unrelated pin from
 ENET group
In-Reply-To: <1501171481-17171-1-git-send-email-fabio.estevam@nxp.com>
References: <1501171481-17171-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170803015312.GF31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 01:04:41PM -0300, Fabio Estevam wrote:
> MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00 is connected to the INT1 pin of
> the FXLS8471Q accelerometer, so remove it from the unrelated ENET
> group.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
