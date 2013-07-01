From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:37:48 +0800
Subject: [PATCH] ARM: dts: imx: remove the unused property
In-Reply-To: <1372410454-14628-1-git-send-email-b32955@freescale.com>
References: <1372410454-14628-1-git-send-email-b32955@freescale.com>
Message-ID: <20130701083746.GB13206@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 05:07:34PM +0800, Huang Shijie wrote:
> The "fsl,gpmi-dma-channel" is not used any more, just remove it
> from all the dts file.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

I already had a patch [1] to clean them up more globally.  And I'm
waiting for all existing users to move to new API. I see this can go
into 3.12.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg227839.html
