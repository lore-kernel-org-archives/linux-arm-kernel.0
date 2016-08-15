From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 Aug 2016 21:12:14 +0800
Subject: [PATCH 1/1] ARM: mach-imx: pm-imx6: add missing
 BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul
In-Reply-To: <1470731083-26213-1-git-send-email-peter.chen@nxp.com>
References: <1470731083-26213-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20160815131214.GD500@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 04:24:43PM +0800, Peter Chen wrote:
> There is a missing BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul,
> without it, the "standby" mode can't work well, the system can't be
> resumed.
> 
> With this commit, the "standby" mode works well.
> 
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: <stable@vger.kernel.org>
> Fixes: ee4a5f838c84 ("ARM: imx: add suspend/resume support for i.mx6ul")
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Applied, thanks.
