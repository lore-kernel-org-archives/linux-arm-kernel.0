From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 4 Sep 2014 11:37:35 +0800
Subject: [PATCH v2 1/3] ARM: dts: imx28-evk: Fix display duplicate name
 warning
In-Reply-To: <1409708714-15136-1-git-send-email-festevam@gmail.com>
References: <1409708714-15136-1-git-send-email-festevam@gmail.com>
Message-ID: <20140904033733.GB10809@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 10:45:12PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The lcdif node has a property named "display" and also a child node
> called "display", which causes the following warning:
> 
> device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"
> 
> Rename the child node name in order to avoid the warning.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied all, thanks.
