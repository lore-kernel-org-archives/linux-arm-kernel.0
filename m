From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 16:19:55 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: Enable pcie
In-Reply-To: <31f5fa5e281b53f10dc25d8abe20ccaa569ad86e.1542739826.git.leonard.crestez@nxp.com>
References: <31f5fa5e281b53f10dc25d8abe20ccaa569ad86e.1542739826.git.leonard.crestez@nxp.com>
Message-ID: <20181128081953.GI20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 06:57:06PM +0000, Leonard Crestez wrote:
> The imx6qdl-sabreauto boards have a pcie slot so let's enable it.
> 
> Tested on imx6dl-sabreauto with an atk9k wifi card; scanning works.
> 
> There are unhandled differences for imx6qp but imx6qp-sabreauto.dts
> already contains a snippet explicitly disabling the &pcie node so that
> can be dealt with later.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
