From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 16 Jan 2010 23:21:53 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <20100116221454.GA8425@elf.ucw.cz>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001162307.48085.rjw@sisk.pl> <20100116221454.GA8425@elf.ucw.cz>
Message-ID: <201001162321.53616.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 January 2010, Pavel Machek wrote:
> Hi!
> 
> > > Agreed, but so what? On PC, machine would power off at that
> > > point. That would surprise the apps, too.
> > > 
> > > Basically new enough userland should not make battery run low enough
> > > for either emergency power off or emergency suspend.
> > 
> > I wonder how it is supposed to achieve that without knowing the current battery
> > status.  Do you mean it should poll the battery driver?
> 
> That's besides point, is it?

Well, mentioned that first. :-)

> Usual kernel<->user interfaces should apply here.

And we're talking about the design of these, aren't we?  The notification about
the critical battery status sent to the user space is a part of the kernel-user
space interface too, after all.

Rafael
