From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 19 Dec 2013 11:48:37 -0800
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <20131219180940.GY2609@titan.lakedaemon.net>
References: <87siton6ke.fsf@natisbad.org>
 <20131219173857.0a546b99@linux.lan.towertech.it>
 <87d2kslphr.fsf@natisbad.org>
 <20131219184024.2a649328@linux.lan.towertech.it>
 <8761qkk96q.fsf@natisbad.org>
 <20131219180940.GY2609@titan.lakedaemon.net>
Message-ID: <20131219194837.GA27311@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 01:09:40PM -0500, Jason Cooper wrote:
> On Thu, Dec 19, 2013 at 07:05:49PM +0100, Arnaud Ebalard wrote:
> > Hi,
> > 
> > Alessandro Zummo <a.zummo@towertech.it> writes:
> > 
> > >> Do you want me to send a v7 w/ the .proc helper removed or leave
> > >> things as they are and Ack the patch as is?
> > >
> > >  Unless absolutely needed, I'd prefer if you can remove them
> > >  or move to sysfs.
> > 
> > Well, my helper provides info on control and status registers flags
> > (just like rtc-isl1208.c does), which are useful mainly for debug I
> > guess. If this can help pushing things forward, I will send a v7 later
> > today w/ the .proc helper removed from the patch.
> 
> Why not convert to debugfs?
> 
Separate follow-on patch, maybe, to keep things going ?

Guenter
