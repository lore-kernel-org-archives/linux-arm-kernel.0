From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 24 Nov 2014 20:06:27 +0100
Subject: v3.18-rc1: n900 battery discharged down to 2.97V
In-Reply-To: <201411241958.34578@pali>
References: <20141124183130.GA2927@amd>
 <201411241958.34578@pali>
Message-ID: <20141124190627.GA7816@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2014-11-24 19:58:34, Pali Roh?r wrote:
> On Monday 24 November 2014 19:31:30 Pavel Machek wrote:
> > Hi!
> > 
> > I left the machine on usb-networking for extended period of
> > time. Unfortunately, Xfce screensaver kept screen busy, and
> > kernel failed to kill the machine.
> > 
> > At the end, hardware protections worked (I guess), but result
> > is battery discharged down to 2.97V.
> 
> So you need some program which will monitor battery status and 
> when battery status is empty it should turn of device.

And that program should be part of the kernel, because kernel should
protect hardware from damage. (And it should be perfectly ok to boot
into init=/bin/bash...)

Anyway, this was just friendly warning, so that you don't
unneccessarily damage your battery...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
