From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 15:36:22 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx: Fix PCI non-prefetchable memory
 range
In-Reply-To: <1513271667-1960-2-git-send-email-festevam@gmail.com>
References: <1513271667-1960-1-git-send-email-festevam@gmail.com>
 <1513271667-1960-2-git-send-email-festevam@gmail.com>
Message-ID: <20171226073620.GA23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 03:14:27PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The third cell of the PCI non-prefetchable memory range should be
> 0x08000000, so change it accordingly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied this one, thanks.
