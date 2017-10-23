From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 08:20:28 +0800
Subject: [PATCH 3/4] ARM: dts: imx28-tx28: fix interrupt flags and use
 interrupts-extended property
In-Reply-To: <20171018084059.022d8116@karo-electronics.de>
References: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
 <1507719939-27250-4-git-send-email-LW@KARO-electronics.de>
 <20171016071726.gyzvalxzk4o3jsuz@pengutronix.de>
 <20171016105632.709e653c@karo-electronics.de>
 <20171018021331.GC18810@dragon>
 <20171018084059.022d8116@karo-electronics.de>
Message-ID: <20171023002026.GA8700@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 08:40:59AM +0200, Lothar Wa?mann wrote:
> > So should I drop all interrupts-extended patches from you?
> >
> Yes, please. Since this patch, and the corresponding patch for tx53
> also fixed the interrupt flags, I will send new patches to only fix
> the interrupt flags.

Okay, the following two got dropped from imx/dt branch.

ARM: dts: imx28-tx28: fix interrupt flags and use interrupts-extended property
ARM: dts: imx53-tx53: fix interrupt flags and use interrupts-extended property

Shawn
