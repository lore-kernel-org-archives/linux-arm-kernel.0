From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Oct 2012 13:02:55 +0300
Subject: [PATCH] Revert "serial: omap: fix software flow control"
In-Reply-To: <20121016151357.GN15569@atomide.com>
References: <1350396562-32579-1-git-send-email-balbi@ti.com>
 <20121016151357.GN15569@atomide.com>
Message-ID: <20121024100254.GG5665@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Tue, Oct 16, 2012 at 08:13:59AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121016 07:16]:
> > This reverts commit 957ee7270d632245b43f6feb0e70d9a5e9ea6cf6
> > (serial: omap: fix software flow control).
> > 
> > As Russell has pointed out, that commit isn't fixing
> > Software Flow Control at all, and it actually makes
> > it even more broken.
> > 
> > It was agreed to revert this commit and use Russell's
> > latest UART patches instead.
> > 
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> This seems like the best way to go for the -rc series:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Any chance you can pick this one up for v3.7-rc3 ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/f432c6f3/attachment.sig>
