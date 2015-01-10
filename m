From: greg@kroah.com (Greg KH)
Date: Sat, 10 Jan 2015 10:17:10 -0800
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110180942.GA10142@amd>
References: <20150110173920.GA31847@amd> <20150110180532.GA8566@kroah.com>
 <20150110180942.GA10142@amd>
Message-ID: <20150110181710.GA8884@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 07:09:42PM +0100, Pavel Machek wrote:
> On Sat 2015-01-10 10:05:32, Greg KH wrote:
> > On Sat, Jan 10, 2015 at 06:39:20PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > N900 has real problems on 3.19, and 2.6.28 should be very well
> > > debugged version. Getting it to compile on recent distribution was
> > > fun, but I succeeded. Unfortunately, Debian 7's udev does not work
> > > with 2.6.28...
> > > 
> > > Does anyone have kernel patches to enable modern udev?
> > 
> > Yes, 3.18, please use that instead.
> 
> Can't, sorry. My goal is to get 3.18/3.19 working, but I really need
> working kernel to debug userland (and then use that userland to debug kernel).
> 
> > Seriously, lots of things have changed, if you want to run a "new"
> > version of udev with an old kernel, try eudev, they have been attempting
> > to keep "legacy" support around in it, don't know how well it has been
> > working though, you really are on your own.
> 
> I was hoping someone has devtmpfs patches I could just apply over
> 2.6.28 and get a working system?

If you want such a crazy thing, you have all of the source to do it
yourself, good luck.
