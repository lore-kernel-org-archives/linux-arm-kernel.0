From: gregkh@suse.de (Greg KH)
Date: Fri, 13 May 2011 09:20:54 -0700
Subject: [PATCH V2] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <1305298982-5789-1-git-send-email-plagnioj@jcrosoft.com>
References: <1305042888-19401-1-git-send-email-plagnioj@jcrosoft.com>
	<1305298982-5789-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110513162054.GC2728@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 05:03:02PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> on 9g20 they are the same as the 9260
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Resent upon Greg's request.
> Based on current linux-next.
> Applies cleanly on current linus' tree (2.6.39-rc7+)
> 
> BTW, can we imagine it going to mainline before .39-final in a "fixes" pull
> request to Linus from a at91 tree?

No, as I don't think this is a bug-fix-only-for-regression, is it?

It looks to be a "fix for new hardware" type thing, right?

And is this really the correct way to do this for the .40 kernel, which
is where I would be queueing this up for?

thanks,

greg k-h
