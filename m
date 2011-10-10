From: gregkh@suse.de (Greg KH)
Date: Mon, 10 Oct 2011 10:00:42 -0700
Subject: [PATCH] fix ehci alignment error
In-Reply-To: <yw1xipnwzu7a.fsf@unicorn.mansr.com>
References: <20111010124154.464239811@gmail.com>
	<20111010141402.GA21856@suse.de>
	<yw1xipnwzu7a.fsf@unicorn.mansr.com>
Message-ID: <20111010170042.GB24166@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 05:29:13PM +0100, M?ns Rullg?rd wrote:
> Greg KH <gregkh@suse.de> writes:
> 
> > On Mon, Oct 10, 2011 at 02:38:27PM +0200, Harro Haan wrote:
> >> The Kirkwood gave an unaligned memory access error on
> >> line 742 of drivers/usb/host/echi-hcd.c:
> >> "ehci->last_periodic_enable = ktime_get_real();"
> >
> > What is "The Kirkwood"?  What size processor is this?
> 
> It's an ARM926-like CPU from Marvell.

32 or 64bit?
