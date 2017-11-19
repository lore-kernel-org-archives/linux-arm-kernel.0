From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Nov 2017 16:07:30 +0100
Subject: bh1770 hacks: get it to work on n950
In-Reply-To: <20171119141213.my7dnc77xbun3gfj@lenoch>
References: <20171116115703.GA26735@amd>
 <20171117113540.3bapqvq6mfuovxuw@earth>
 <20171119124150.GA25154@amd>
 <20171119141213.my7dnc77xbun3gfj@lenoch>
Message-ID: <20171119150730.GA2366@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2017-11-19 15:12:13, Ladislav Michl wrote:
> On Sun, Nov 19, 2017 at 01:41:50PM +0100, Pavel Machek wrote:
> > On Fri 2017-11-17 12:35:40, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > Ok, not for application, but I can get light sensor to work.
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > There is no mainline user of this driver and it has a custom API, so
> > > I think the driver should be dropped and an IIO based one should be
> > > created instead.
> > 
> > While I agree IIO interface might be better, and would welcome
> > patches, I don't think that dropping the driver is right action at
> > this point.
> 
> That's the most elegant solution at all. How would you later motivate
> people to try and test IIO driver? Let's pretend this patch have never
> existed until someone notices and starts playing "you broke kernel ABI"
> game.

I'm using the driver; I'm even interested in fixing it. Please try not
to make my job any harder than it needs to be, and I'll try to break
ABI.

That goes to Sebastian, too.

If you want to convert the driver to IIO, please do so, I can test the patches.

Thank you,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171119/ec8d8ac6/attachment.sig>
