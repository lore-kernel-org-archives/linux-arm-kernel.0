From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 10:07:12 +0800
Subject: [PATCH 1/4] ARM: clk-imx6sl: Remove csi_lcdif_sels[]
In-Reply-To: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
References: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140825020711.GH2540@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 03:21:11PM -0300, Fabio Estevam wrote:
> Currently csi_lcdif_sels[] is a shared array for the providing the possible 
> clock parents for csi and lcdif blocks.
> 
> This is not correct, as csi and lcdif do not share the same clock parents.
> 
> Introduce csi_sels[] for the csi and lcdif_axi_sels[] for the lcdif clocks in
> order to describe the parents correctly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied all 4, thanks.
