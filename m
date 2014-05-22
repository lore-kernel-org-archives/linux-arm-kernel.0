From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 22 May 2014 13:33:11 +0800
Subject: [PATCH] ARM: imx: fix error handling in ipu device registration
In-Reply-To: <20140522051850.GC32618@quad.lixom.net>
References: <1400483274-13680-1-git-send-email-shawn.guo@freescale.com>
 <20140522051850.GC32618@quad.lixom.net>
Message-ID: <20140522053308.GB32184@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 10:18:50PM -0700, Olof Johansson wrote:
> BTW, it was requested to use a 12-character SHA in the Fixes: tag, since in the
> future there might be a collision on the shortest one.
> 
> You can update the default for your git repo by setting the core.abbrevlength
> config variable to 12.

Done. Thanks for the hint, Olof.

BTW, not sure what your git version is, but with my version 1.8.3.2 the
variable seems to be core.abbrev instead of core.abbrevlength, probably
because of the change below?

http://git.kaarsemaker.net/git/commit/a71f09fe3e8b047d88b5f439c6d552e8fc7e8293/

Shawn
