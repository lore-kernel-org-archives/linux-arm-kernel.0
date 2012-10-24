From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Oct 2012 21:53:04 +0300
Subject: [PATCH] Revert "serial: omap: fix software flow control"
In-Reply-To: <20121024185742.GA26995@kroah.com>
References: <1350396562-32579-1-git-send-email-balbi@ti.com>
 <20121016151357.GN15569@atomide.com>
 <20121024100254.GG5665@arwen.pp.htv.fi>
 <20121024185742.GA26995@kroah.com>
Message-ID: <20121024185304.GA772@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 11:57:42AM -0700, Greg KH wrote:
> On Wed, Oct 24, 2012 at 01:02:55PM +0300, Felipe Balbi wrote:
> > Hi Greg,
> > 
> > On Tue, Oct 16, 2012 at 08:13:59AM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [121016 07:16]:
> > > > This reverts commit 957ee7270d632245b43f6feb0e70d9a5e9ea6cf6
> > > > (serial: omap: fix software flow control).
> > > > 
> > > > As Russell has pointed out, that commit isn't fixing
> > > > Software Flow Control at all, and it actually makes
> > > > it even more broken.
> > > > 
> > > > It was agreed to revert this commit and use Russell's
> > > > latest UART patches instead.
> > > > 
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > 
> > > This seems like the best way to go for the -rc series:
> > > 
> > > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > Any chance you can pick this one up for v3.7-rc3 ?
> 
> Now queued up, sorry for the delay.

no problems, thanks a lot.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/ef6464e0/attachment.sig>
