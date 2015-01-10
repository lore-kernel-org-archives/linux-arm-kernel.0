From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 11 Jan 2015 00:59:27 +0200
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110211805.GZ22149@ZenIV.linux.org.uk>
References: <20150110173920.GA31847@amd>
 <20150110191335.GA5125@fuloong-minipc.musicnaut.iki.fi>
 <20150110211805.GZ22149@ZenIV.linux.org.uk>
Message-ID: <20150110225927.GB5125@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 10, 2015 at 09:18:05PM +0000, Al Viro wrote:
> On Sat, Jan 10, 2015 at 09:13:35PM +0200, Aaro Koskinen wrote:
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

In glibc 2.20 the minimum kernel version was increased to 2.6.32.
Maybe this patch gives some examples what features they now expect
to be present:

	https://sourceware.org/ml/libc-alpha/2014-04/msg00691.html

But looks like Debian 7 is not bleeding-edge and is using older version...

A.
