From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 20:00:04 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628114815.GL6406@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <20120628114815.GL6406@shlinux2.ap.freescale.net>
Message-ID: <20120628120002.GG22990@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 07:48:16PM +0800, Dong Aisheng wrote:
> Yes, that is a solution.
> But it may not so reasonable since dts file should represent hw, but here
> we have to do some trick by we know how driver works.
> Maybe we need find a better solution.
> 
I wouldn't agree that driver should take care of all such kind of board
weirdness.

-- 
Regards,
Shawn
