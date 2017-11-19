From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Nov 2017 13:41:50 +0100
Subject: bh1770 hacks: get it to work on n950
In-Reply-To: <20171117113540.3bapqvq6mfuovxuw@earth>
References: <20171116115703.GA26735@amd>
 <20171117113540.3bapqvq6mfuovxuw@earth>
Message-ID: <20171119124150.GA25154@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-11-17 12:35:40, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > Ok, not for application, but I can get light sensor to work.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> There is no mainline user of this driver and it has a custom API, so
> I think the driver should be dropped and an IIO based one should be
> created instead.

While I agree IIO interface might be better, and would welcome
patches, I don't think that dropping the driver is right action at
this point.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171119/72be498d/attachment.sig>
