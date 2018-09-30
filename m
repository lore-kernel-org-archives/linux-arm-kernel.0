From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 30 Sep 2018 11:16:33 +0800
Subject: [PATCH] ARM: dts: imx53-ppd: Remove 'num-chipselects' property
In-Reply-To: <1537892648-30414-1-git-send-email-festevam@gmail.com>
References: <1537892648-30414-1-git-send-email-festevam@gmail.com>
Message-ID: <20180930031631.GL26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 01:24:08PM -0300, Fabio Estevam wrote:
> The 'num-chipselects' property is not a valid property according
> to Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt, so
> let's remove it.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
