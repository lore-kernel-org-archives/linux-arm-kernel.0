From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Jul 2017 15:58:36 +0800
Subject: [PATCH] ARM: dts: imx6qdl-icore-rqs: Remove unneeded 'fsl, mode'
 property
In-Reply-To: <1499183961-10237-1-git-send-email-fabio.estevam@nxp.com>
References: <1499183961-10237-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170713075834.GN3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 12:59:21PM -0300, Fabio Estevam wrote:
> imx6qdl-icore-rqs boards use sgtl5000 codec and the machine
> file (imx-sgtl5000) already sets SSI in slave mode and codec in
> master mode, so there is no need for having this property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
