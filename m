From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Apr 2012 12:20:30 +0100
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <1335522130.31825.135.camel@vkoul-udesk3>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
 <20120427084109.GO28063@b20223-02.ap.freescale.net>
 <1335522130.31825.135.camel@vkoul-udesk3>
Message-ID: <20120427112030.GF18260@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:52:10PM +0530, Vinod Koul wrote:
> On Fri, 2012-04-27 at 16:41 +0800, Richard Zhao wrote:

> > Then, could you please doc it somewhere? I think I'm not the only one
> > confused.

> See the soc-dmaengine.c for correct behavior!

Better yet, convert your code to use it if it's not doing so already!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/8248e2a2/attachment.sig>
