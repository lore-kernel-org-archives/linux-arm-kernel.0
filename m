From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 14:37:38 +0800
Subject: [PATCH] clk: imx6sx: Register SAI clocks as shared clocks
In-Reply-To: <1457440419-5494-1-git-send-email-festevam@gmail.com>
References: <1457440419-5494-1-git-send-email-festevam@gmail.com>
Message-ID: <20160331063738.GR28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 09:33:39AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> SAIx and SAIx_IPG share the same bit fields in the CCM registers, so
> we should better register them via imx_clk_gate2_shared(). 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
