From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 4 Apr 2011 14:29:06 -0700
Subject: WARNING: at mm/page_alloc.c
In-Reply-To: <20110404132226.GA14806@atrey.karlin.mff.cuni.cz>
References: <20110404132226.GA14806@atrey.karlin.mff.cuni.cz>
Message-ID: <20110404212906.GA984@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 03:22:26PM +0200, Cyril Hrubis wrote:
> Hi!
> I'm playing with uinput on zaurus (spitz) I've a pxa-2.6 kernel flashed in the
> uinput is loaded as module. Right after my program called:
> 
> ioctl(fd, UI_DEV_CREATE);
> 
> I've got:
> 
> WARNING: at mm/page_alloc.c:2012 __alloc_pages_nodemask+0148/0x5a8()
> 
> and the ioctl() has failed.
> 
> Anybody has an idea what went wrong?

You do not have enough memory?

Maybe if you could post your program we could see what exactly went
wrong...

Thanks.

-- 
Dmitry
