From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:23:20 -0500
Subject: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
In-Reply-To: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180326222320.kcbudvanuyvo42fa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 10:30:44AM +0800, Anson Huang wrote:
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
> ---
>  drivers/clk/imx/clk-imx6sx.c             | 8 ++++++--
>  include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
