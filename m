From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 20:19:37 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628120245.GM6406@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <20120628114815.GL6406@shlinux2.ap.freescale.net>
 <20120628120245.GM6406@shlinux2.ap.freescale.net>
Message-ID: <20120628121935.GK22990@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:02:46PM +0800, Dong Aisheng wrote:
> One more thing, for such dt representation, if can0 phy is disabled,
> can1 may be disabled wrongly too, right?
> 
Right.  Looks like we have to take care of the weirdness then.

-- 
Regards,
Shawn
