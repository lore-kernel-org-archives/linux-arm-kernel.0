From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Thu, 3 Nov 2016 23:49:00 +0200
Subject: [PATCHv6] support for AD5820 camera auto-focus coil
In-Reply-To: <20161103102727.GA10084@amd>
References: <20160527205140.GA26767@amd> <20160805102611.GA13116@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
 <20160808214132.GB2946@xo-6d-61-c0.localdomain>
 <20160810120105.GP3182@valkosipuli.retiisi.org.uk>
 <20160808232323.GC2946@xo-6d-61-c0.localdomain>
 <20160811111633.GR3182@valkosipuli.retiisi.org.uk>
 <20160818104539.GA7427@amd>
 <20160818202559.GF3182@valkosipuli.retiisi.org.uk>
 <20161103102727.GA10084@amd>
Message-ID: <20161103214900.GH3217@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 11:27:27AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > > Yeah. I just compiled it but haven't tested it. I presume it'll work. :-)
> > > > > 
> > > > > I'm testing it on n900. I guess simpler hardware with ad5820 would be better for the
> > > > > test...
> > > > > 
> > > > > What hardware do you have?
> > > > 
> > > > N900. What else could it be? :-) :-)
> > > 
> > > Heh. Basically anything is easier to develop for than n900 :-(.
> > 
> > Is it?
> > 
> > I actually find the old Nokia devices very practical. It's easy to boot your
> > own kernel and things just work... until musb broke a bit recently. It
> > requires reconnecting the usb cable again to function.
> > 
> > I have to admit I mostly use an N9.
> 
> Well, if you compare that to development on PC, I prefer PC.
> 
> Even arm development boards are usually easier, as they don't need too
> complex userspace, and do have working serial ports.
> 
> But I do have a serial adapter for N900 now (thanks, sre), so my main
> problem now is that N900 takes a lot of time to boot into usable
> state.

Yeah... I just upgraded my Debian installation (armel over NFS) a few major
numbers and I find it a lot slower than it used to do. I presume that's
mostly because of systemd...

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
