From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 21 Nov 2012 12:21:14 -0800
Subject: [PATCH] Revert "serial: omap: fix software flow control"
In-Reply-To: <509A306B.10409@gmail.com>
References: <1350396562-32579-1-git-send-email-balbi@ti.com>
 <509A306B.10409@gmail.com>
Message-ID: <20121121202114.GC30682@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 10:56:59AM +0100, Andreas Bie?mann wrote:
> On 16.10.2012 16:09, Felipe Balbi wrote:
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
> since 957ee7270d632245b43f6feb0e70d9a5e9ea6cf6 made it into stable (at
> least 3.4) I think it would be good decision to also apply this revert
> to stable until a working solution exists.

Now queued up for the stable releases, thanks.

greg k-h
