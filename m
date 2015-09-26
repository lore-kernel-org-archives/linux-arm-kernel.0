From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 25 Sep 2015 17:39:10 -0700
Subject: [PATCH v6 3/6] pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <1443215162-13716-3-git-send-email-aalonso@freescale.com>
References: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
 <1443215162-13716-3-git-send-email-aalonso@freescale.com>
Message-ID: <20150926003909.GD3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 04:05:59PM -0500, Adrian Alonso wrote:
> Allow mux_reg offset zero to be a valid pin_id, on imx7d
> mux_conf reg offset is zero for iomuxc-lspr controller
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

For #3 ~ #6,

Acked-by: Shawn Guo <shawnguo@kernel.org>
