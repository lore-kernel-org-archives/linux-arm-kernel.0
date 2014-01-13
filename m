From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 16:09:25 +0800
Subject: [PATCH V3 1/5] ARM: imx: add suspend in ocram support on i.mx6q
In-Reply-To: <1389592718-9999-1-git-send-email-b20788@freescale.com>
References: <1389592718-9999-1-git-send-email-b20788@freescale.com>
Message-ID: <20140113080923.GR23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:58:34PM +0800, Anson Huang wrote:
> +			pm_info->mmdc_io_val[i][1] =
> +				readl_relaxed(*(&pm_info->iomuxc_base.vbase) +

*(&pm_info->iomuxc_base.vbase) is just pm_info->iomuxc_base.vbase

Shawn

> +				imx6q_mmdc_io_dsm_offset[i]);
