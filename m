From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 11 Oct 2013 08:36:40 -0700
Subject: [PATCH] serial: prepare for 9bit data
In-Reply-To: <5257E804.6020800@aksignal.cz>
References: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
 <20130926224755.GA15399@kroah.com> <5257E804.6020800@aksignal.cz>
Message-ID: <20131011153640.GB14715@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 01:59:00PM +0200, Ji?? Prchal wrote:
> 
> 
> Dne 27.9.2013 00:47, Greg KH napsal(a):
> >On Mon, Sep 23, 2013 at 02:07:32PM +0200, Jiri Prchal wrote:
> >>This patch adds 9bit data possibility for serial_core. Please confirm that I did it right way at right place. I'll make atmel_serial driver for 9bit data later.
> >
> >Please wrap your lines properly.
> >
> >I'd rather wait to add this type of patch _after_ you have tested it and
> >verified that your driver works, and take that patch at the same time.
> >
> >Otherwise, this is just added cruft that no one is using, and I'd have
> >to remove it :)
> No one is using it because it is NOT implemented.

Then implement it.

> Try to search internet for "9bit serial" to see how many people like to use it.

Again, then implement it, I can't add code to the kernel that no one
uses, that would be cruft and be deleted, right?

> But I probably not bother to do it and I'll try some tricks with parity.
> As many others.

Why not just implement it, then it can stay, right?

thanks,

greg k-h
