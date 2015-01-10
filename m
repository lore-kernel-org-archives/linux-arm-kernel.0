From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sat, 10 Jan 2015 21:18:58 +0000
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110181710.GA8884@kroah.com>
References: <20150110173920.GA31847@amd> <20150110180532.GA8566@kroah.com>
 <20150110180942.GA10142@amd> <20150110181710.GA8884@kroah.com>
Message-ID: <20150110211857.GA22149@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 10:17:10AM -0800, Greg KH wrote:
> > > Yes, 3.18, please use that instead.
> > 
> > Can't, sorry. My goal is to get 3.18/3.19 working, but I really need
> > working kernel to debug userland (and then use that userland to debug kernel).
> > 
> > > Seriously, lots of things have changed, if you want to run a "new"
> > > version of udev with an old kernel, try eudev, they have been attempting
> > > to keep "legacy" support around in it, don't know how well it has been
> > > working though, you really are on your own.
> > 
> > I was hoping someone has devtmpfs patches I could just apply over
> > 2.6.28 and get a working system?
> 
> If you want such a crazy thing, you have all of the source to do it
> yourself, good luck.

... and this, boys and girls, is why quite a few of us have loathed udev
way before it got merged into even nastier shitpile.  Still do, for that
matter.
