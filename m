From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Oct 2014 21:29:37 +0200
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141019191937.GA6438@amd>
References: <20141019090107.GA19132@amd> <20141019100739.GA2547@amd>
 <20141019152414.GB5189@saruman> <20141019191937.GA6438@amd>
Message-ID: <20141019192937.GA9788@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-10-19 21:19:37, Pavel Machek wrote:
> Hi!
> 
> On Sun 2014-10-19 10:24:14, Felipe Balbi wrote:
> > Hi,
> > On Sun, Oct 19, 2014 at 12:07:39PM +0200, Pavel Machek wrote:
> > > On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > From 3.6 to 3.10, USB networking works on Nokia N900. With 3.11, it
> > > > fails with messages on the host. I also tried to get it to work on
> > > > 3.14 and 3.17, with no luck.
> > > > 
> > > > Any ideas? Does it work for you? Any config options to watch for?
> > > 
> > > With 3.17, I get
> > > 
> > > omap_musb_mailbox: musb core is not yet ready

For the record, I can't see the message in this try. Either it is not
there, or it scrolled away (there's unfortunately no way to scroll
back).

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
