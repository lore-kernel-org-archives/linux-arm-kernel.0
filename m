From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 22 Sep 2017 14:57:51 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_MUX_MMIO
In-Reply-To: <1505609186-21727-1-git-send-email-festevam@gmail.com>
References: <1505609186-21727-1-git-send-email-festevam@gmail.com>
Message-ID: <20170922065750.GG26358@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 16, 2017 at 09:46:26PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> In order to get ADV7180 analog video decoder to probe on a Gateworks
> GW51xx we need select CONFIG_MUX_MMIO, otherwise /dev/media node does
> not get created.
> 
> Select CONFIG_MUX_MMIO, so that the ADV7180 driver can be correctly
> probed.
> 
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Suggested-by: Steve Longerbeam <slongerbeam@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
