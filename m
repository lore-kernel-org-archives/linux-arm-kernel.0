From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 May 2012 09:41:23 +0800
Subject: [PATCH 1/4] GPMI-NAND: Define ecc.strength
In-Reply-To: <201205210336.41860.marex@denx.de>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <20120521011455.GL5427@S2101-09.ap.freescale.net>
 <201205210336.41860.marex@denx.de>
Message-ID: <20120521014121.GO5427@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 03:36:41AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > So non-DT probe has the same issue?  Or this is a DT probe only issue?
> 
> I started using DT, so I'm now fixing everything to work like it used to. Damn 
> this DT conversion broke about everything.
> 
So you are saying the issue is introduced by gpmi-nand DT conversion?

-- 
Regards,
Shawn
