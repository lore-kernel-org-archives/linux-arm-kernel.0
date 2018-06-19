From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 Jun 2018 10:55:55 +0800
Subject: [PATCH] ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
In-Reply-To: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
References: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
Message-ID: <20180619025554.GC16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 04:11:09PM +0300, Leonard Crestez wrote:
> Two different regulators are defined with the same name and label but
> distinct properties.
> 
> The first definition was added with the first board dts and the second
> was added when upstream added flexcan support.
> 
> Looking at schematics it is indeed gpio2 14 connected to the STB pin of
> the CAN transceiver so remove the first definition.
> 
> The second definition entirely overrides the first so this already
> worked and this patch results in no DTB change, just a cleanup.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
