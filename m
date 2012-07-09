From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 11:50:10 +0200
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <20120709090239.GH11635@S2101-09.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <201207091046.36886.marex@denx.de>
 <20120709090239.GH11635@S2101-09.ap.freescale.net>
Message-ID: <201207091150.10910.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, Jul 09, 2012 at 10:46:36AM +0200, Marek Vasut wrote:
> > Well ... the support for that board that's in current mainline is pretty
> > deprecated. And I wasn't really able to update it due to all the DT hype,
> > you know the rest of the story more then well etc. etc.
> 
> Let's remove it then :)

Yea.

> > To start the enet_out clock.
> 
> Will take care of it in m28evk_init().

But almost every board needs that hack ... won't it be easier to make it into 
default behavior? Or can we not somehow configure this via DT itself?

Best regards,
Marek Vasut
