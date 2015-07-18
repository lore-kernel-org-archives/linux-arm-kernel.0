From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 18 Jul 2015 09:31:53 +0200 (CEST)
Subject: [PATCH 3/5] arm64: mediatek: enable MTK_TIMER
In-Reply-To: <1956087.MUsCyY7Qyv@ubix>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436779969-18610-4-git-send-email-yingjoe.chen@mediatek.com>
 <1956087.MUsCyY7Qyv@ubix>
Message-ID: <alpine.DEB.2.11.1507180931190.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015, Matthias Brugger wrote:

> On Monday, July 13, 2015 05:32:47 PM Yingjoe Chen wrote:
> > Enable MTK_TIMER for MediaTek plaform, which will be used as
> > schedule clock.
> > 
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> 
> Applied, thanks.

So you enable the current code w/o the modifications required for this
to work?

Thanks,

	tglx
