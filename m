From: greg@kroah.com (Greg Kroah-Hartman)
Date: Thu, 17 Dec 2015 08:27:36 -0800
Subject: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
In-Reply-To: <CAOZdJXVz5Bm2-XBNjoU6uh=i2E0Mq915entU+rz-MqD8F4C=xQ@mail.gmail.com>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
 <20151213060643.GA30667@kroah.com>
 <CAOZdJXVz5Bm2-XBNjoU6uh=i2E0Mq915entU+rz-MqD8F4C=xQ@mail.gmail.com>
Message-ID: <20151217162736.GA5897@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 09:55:30AM -0600, Timur Tabi wrote:
> On Sun, Dec 13, 2015 at 12:06 AM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> 
> >> Example:
> >>
> >>       earlycon=pl011,mmio32,0x3ced1000
> >>
> >> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> >> ---
> >>
> >> This patch applies on top of Russell's 12-part amba-pl011.c patchset.
> >
> > Which I didn't apply, so can you resend this after he resends his?
> 
> I see that some of Russell's patches are now in tty-next.  Does that
> make them official?

Unless Russell asks me to revert them, they will show up in the next
merge window.

> There was some disagreement about the usage of
> access_32b vs uap->port.iotype for determining whether we need 32-bit
> accessors or not.

There was?  I missed that, please send follow-on patches to resolve the
issue if there is one.

thanks,

greg k-h
