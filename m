From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 May 2018 21:15:26 +0800
Subject: [PATCH V3 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
In-Reply-To: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
References: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180502131524.GJ3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:38:10PM +0800, Anson Huang wrote:
> i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> And this lvds2, along with lvds1, can be used to provide
> external clock source to the internal pll, such as pll4_audio
> and pll5_video.
> 
> This patch mainly adds the lvds2 to the clock tree and fix its
> relationship with pll accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
