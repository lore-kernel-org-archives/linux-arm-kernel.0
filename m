From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 10 Jan 2015 23:49:02 +0100
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110211805.GZ22149@ZenIV.linux.org.uk>
References: <20150110173920.GA31847@amd>
 <20150110191335.GA5125@fuloong-minipc.musicnaut.iki.fi>
 <20150110211805.GZ22149@ZenIV.linux.org.uk>
Message-ID: <20150110224902.GA25534@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2015-01-10 21:18:05, Al Viro wrote:
> On Sat, Jan 10, 2015 at 09:13:35PM +0200, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Sat, Jan 10, 2015 at 06:39:20PM +0100, Pavel Machek wrote:
> > > N900 has real problems on 3.19, and 2.6.28 should be very well
> > > debugged version. Getting it to compile on recent distribution was
> > > fun, but I succeeded. Unfortunately, Debian 7's udev does not work
> > > with 2.6.28...
> > 
> > I guess you will have many other issues too if you want to run
> > such combination (legacy kernel + modern userspace). E.g. current glibc
> > requires >= 2.6.32.
> 
> How current is current and just what does it require in 2.6.32?

Debian 7 seems to contain

root at n900:~# ls /lib/arm-linux-gnueabi/libc
libc-2.13.so

. And that one seems to be happy with 2.6.28. Its just udev that is
the problem.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
