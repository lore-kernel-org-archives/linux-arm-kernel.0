From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 May 2014 09:37:16 +0900
Subject: [PATCH v5] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <20140523203900.23136.74970@quantum>
References: <1400851635-27116-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <20140523203900.23136.74970@quantum>
Message-ID: <20140526003716.GA730@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Cc ARM-SoC Maintainers <arm@kernel.org> ]

On Fri, May 23, 2014 at 01:39:00PM -0700, Mike Turquette wrote:
> Quoting Ulrich Hecht (2014-05-23 06:27:15)
> > Driver for the R8A7740's clocks that are too specific to be supported by a
> > generic driver.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Taken into clk-next.

Thanks Mike!

I would like to queue-up integration patches that depend on this one.
Ideally for v3.17.

Do you expect this patch to appear in v3.16-rc1?  If not would it be
possible for you to provide a branch with stable commit ids that I could
use as a base?
