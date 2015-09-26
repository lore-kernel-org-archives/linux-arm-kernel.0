From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 25 Sep 2015 17:28:49 -0700
Subject: [PATCH v6 1/6] ARM: dts: imx: imx7d add iomuxc lpsr device node
In-Reply-To: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
References: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
Message-ID: <20150926002848.GA3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 04:05:57PM -0500, Adrian Alonso wrote:
> Add device tree node to support iomuxc-lpsr controller, fsl,iput-sel
> phandle allows to get input select register base address which is
> shared from main iomuxc controller.
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

For the series,

Acked-by: Shawn Guo <shawnguo@kernel.org>
