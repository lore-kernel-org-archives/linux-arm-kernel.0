From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 15 May 2012 08:19:38 -0700
Subject: [PATCH v1 1/7] usb: chipidea: permit user select
 USB_EHCI_ROOT_HUB_TT
In-Reply-To: <201205151627.15428.marex@denx.de>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-2-git-send-email-richard.zhao@freescale.com>
 <201205151627.15428.marex@denx.de>
Message-ID: <20120515151938.GD23916@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 04:27:15PM +0200, Marek Vasut wrote:
> Dear Richard Zhao,
> 
> > The ci13xxx hcd require USB_EHCI_ROOT_HUB_TT.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 
> I already sent similar patch a few hours ago.

But yours was more "complete" :)

I'll queue up yours in a bit, thanks.

greg k-h
