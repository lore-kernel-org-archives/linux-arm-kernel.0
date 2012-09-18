From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 16:20:58 +0800
Subject: [PATCH 00/34] i.MX multi-platform support
In-Reply-To: <20120917075138.GN6180@pengutronix.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <20120917075138.GN6180@pengutronix.de>
Message-ID: <20120918082055.GD6377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 09:51:38AM +0200, Sascha Hauer wrote:
> I gave it a test on i.MX1, i.MX27, i.MX31 and i.MX35. All run fine, but
> the last patch breaks the imx_v4_v5_defconfig: Somehow it now defaults
> to ARMv7 based machines. I haven't looked into it, just reenabled
> ARMv4/ARMv5 and the boards again -> works. The config should be updated
> with the last patch.
> 
Yes, I will rework the patch with all these and Arnd's comment on the
last patch taken into account.

> I'm fine with the changes to mx2-camera, but Javier should give his ok
> to it, he has worked on it quite a lot recently.
> 
> One other issue related to imx-dma, see comment to that patch.
> 
> Otherwise:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
Thanks a lot.

Shawn
