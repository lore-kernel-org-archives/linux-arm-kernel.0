From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 3 May 2014 18:09:49 -0400
Subject: [PATCH 0/5] tty/serial: Add helpers to use GPIOs to control
 modem lines and implement atmel_serial.c
In-Reply-To: <CACQ1gAiyonHpg5YP4nSd3B=iiVQoTKQvYoC_JxbzA6Dmzr8+tw@mail.gmail.com>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
 <20140425155847.GC22879@kroah.com>
 <CACQ1gAiyonHpg5YP4nSd3B=iiVQoTKQvYoC_JxbzA6Dmzr8+tw@mail.gmail.com>
Message-ID: <20140503220949.GB10927@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 11:58:45AM +0200, Richard Genoud wrote:
> 2014-04-25 17:58 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > On Fri, Apr 25, 2014 at 04:52:36PM +0200, Richard Genoud wrote:
> >> This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
> >> that missed 3.15 because it caused merge conflicts.
> >>
> >> The 1st patch may be applied as a fix for 3.15-rc, since it correct a
> >> device tree binding documentation example.
> >>
> >> Greg, for you to decide if it's worth it or not !
> >
> > Why am I the one tho decides if it is worth it?  If it's up to me, I'll
> > just say "no", as I sure don't need this for any of my machines...
> 
> Ok, let me reformulate :) :
> 
> This patch series is a leftover of
> http://www.spinics.net/lists/arm-kernel/msg314242.html
> that missed 3.15 because it caused merge conflicts (you acked the
> series and ask me to resend it during 3.15-rc cycle).
> 
> I think that "[PATCH 1/5] tty/serial: atmel_serial: Fix device tree
> documentation" should be applied on 3.15-rc,
> since it corrects a device tree binding documentation example.
> 
> The patches 2-5/5 are for 3.16.

Ok, can you resend these, with a note that the first one should make it
to 3.15-final, and I'll queue them up?

thanks,

greg k-h
