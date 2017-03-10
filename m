From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 10 Mar 2017 06:35:18 +0100
Subject: [PATCH 1/3] ARM: dts: imx6qp: reference PCIe node by handle
In-Reply-To: <20170217134837.14173-1-l.stach@pengutronix.de>
References: <20170217134837.14173-1-l.stach@pengutronix.de>
Message-ID: <20170310053516.GC5848@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 02:48:35PM +0100, Lucas Stach wrote:
> By using the handle, we can avoid some duplication of the base DT
> and so avoid any maintenance overhead in the QP DT if the referenced
> node changes.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied all, thanks.
