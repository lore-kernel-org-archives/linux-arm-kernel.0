From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 17:02:41 +0800
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207091046.36886.marex@denx.de>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <201207091018.25979.marex@denx.de>
 <20120709084032.GF11635@S2101-09.ap.freescale.net>
 <201207091046.36886.marex@denx.de>
Message-ID: <20120709090239.GH11635@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 10:46:36AM +0200, Marek Vasut wrote:
> Well ... the support for that board that's in current mainline is pretty 
> deprecated. And I wasn't really able to update it due to all the DT hype, you 
> know the rest of the story more then well etc. etc.
> 
Let's remove it then :)

> To start the enet_out clock.
> 
Will take care of it in m28evk_init().

-- 
Regards,
Shawn
