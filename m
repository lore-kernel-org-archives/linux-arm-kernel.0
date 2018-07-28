From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 28 Jul 2018 23:11:10 +0200
Subject: new libv4l2 (was Re: [PATCH, libv4l]: Make libv4l2 usable on devices
 with complex pipeline)
In-Reply-To: <20180723153649.73337c0f@coco.lan>
References: <20180708213258.GA18217@amd> <20180719205344.GA12098@amd>
 <20180723153649.73337c0f@coco.lan>
Message-ID: <20180728211110.GB1152@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Add support for opening multiple devices in v4l2_open(), and for
> > > mapping controls between devices.
> > > 
> > > This is necessary for complex devices, such as Nokia N900.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>  
> > 
> > Ping?
> > 
> > There's a lot of work to do on libv4l2... timely patch handling would
> > be nice.
> 
> As we're be start working at the new library in order to support
> complex cameras, and I don't want to prevent you keeping doing your
> work, IMHO the best way to keep doing it would be to create two
> libv4l2 forks:

BTW.. new library. Was there decision what langauge to use? I know C
is obvious choice, but while working on libv4l2, I wished it would be
Rust...

Rewriting same routine over and over, with slightly different types
was not too much fun, and it looked like textbook example for
generics...

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180728/8180ed05/attachment.sig>
