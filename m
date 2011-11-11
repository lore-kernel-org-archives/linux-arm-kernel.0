From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 12 Nov 2011 07:26:35 +0800
Subject: [PATCH 1/4] arm/imx: fix mx3_defconfig to add FEC back
In-Reply-To: <20111111155851.GC16886@pengutronix.de>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
 <1320914372-4416-2-git-send-email-shawn.guo@linaro.org>
 <20111111155851.GC16886@pengutronix.de>
Message-ID: <20111111232635.GC9471@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 04:58:51PM +0100, Sascha Hauer wrote:
> On Thu, Nov 10, 2011 at 04:39:29PM +0800, Shawn Guo wrote:
> > The commit 'd880db0 arm: mx3: update defconfig' removes FEC support
> > which is not good, since FEC is useful for both developers and users.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I skipped this one for now as I have hope to get the i.MX5 merge into
> -rc which would remove this file. If not, I'll send this one later.
> 
Sound good.

-- 
Regards,
Shawn
