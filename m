From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 21:48:34 +0200
Subject: [PATCH 2/9] USB: move bulk of otg/otg.c to phy/phy.c
In-Reply-To: <20130219190635.GB1906@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-3-git-send-email-s.hauer@pengutronix.de>
 <20130219093019.GG23197@arwen.pp.htv.fi>
 <20130219190635.GB1906@pengutronix.de>
Message-ID: <20130219194834.GC8978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 08:06:35PM +0100, Sascha Hauer wrote:
> On Tue, Feb 19, 2013 at 11:30:19AM +0200, Felipe Balbi wrote:
> > On Mon, Feb 04, 2013 at 02:24:28PM +0100, Sascha Hauer wrote:
> > > Most of otg/otg.c is not otg specific, but phy specific, so move it
> > > to the phy directory.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > 
> > this is pretty ok, I'll start queueing patches for v3.10 in about a week
> > or two.
> 
> Ok, thanks. I'll resend this after the merge window.

cool great, that lets me wait for v3.9-rc1 before queueing, much
better ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/0d6f7277/attachment-0001.sig>
