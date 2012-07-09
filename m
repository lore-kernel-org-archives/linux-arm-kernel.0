From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 17:00:49 +0800
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207091050.31528.marex@denx.de>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <201207091018.25979.marex@denx.de>
 <20120709084032.GF11635@S2101-09.ap.freescale.net>
 <201207091050.31528.marex@denx.de>
Message-ID: <20120709090047.GG11635@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 10:50:31AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> [...]
> 
> Shouldn't MACH_MXS_DT now select MXS_OCOTP ? It kinda doesn't compile without 
> it.
> 
Yes, you are right.  However, I'm considering to remove both MXS_OCOTP
and MACH_MXS_DT and have them always compiled.  When we convert all
those board files to DT, mach-mxs.c will be always built and all those
MACH_* will no longer exist.

-- 
Regards,
Shawn
