From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 12:15:19 +0800
Subject: [PATCH] ARM: dts: imx51: add CodaHx4 VPU
In-Reply-To: <20171213142406.5088-1-p.zabel@pengutronix.de>
References: <20171213142406.5088-1-p.zabel@pengutronix.de>
Message-ID: <20171226041517.GD4210@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 03:24:06PM +0100, Philipp Zabel wrote:
> Add the CodaHx4 VPU to the i.MX51 device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> This patch should only be applied once the patch to fix VPU register access on
> i.MX51 [1] is merged. The coda driver with patches [2] applied will start
> accessing VPU registers on i.MX51, which hangs the system without [1].

Ping me when it can be safely applied on IMX tree.

Shawn
