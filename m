From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 21 May 2018 23:39:53 +0200
Subject: v4.17-rc1: regressions on N900, N950
In-Reply-To: <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
Message-ID: <20180521213952.GA11596@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI!

> On Sun, Apr 22, 2018 at 09:42:13AM +0200, Pavel Machek wrote:
> > v4.17-rc1 broke display for me on Nokia N900. (I don't know if system
> > boots, but I can see on red flash LED that at least that driver
> > succeeded. So it should not be early boot crash).
> > 
> > v4.17-rc1 also broke boot on N950.
> > 
> > Any ideas? Does it work for you?
> 
> Below config works for me on N900 and N950. (On N950, I need to disable to
> display DTS entry as discussed in other threads.)

Thanks... On N900 it works for me in v4.16, but display stays blank in
v4.17-rc1...

And I'm starting to suspect I have somehow special N900, or maybe
special gcc version... Whether display on N900 works or not seems to
depend on completely unrelated config options :-(. Maybe it is timing
during boot or something.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/f252dd08/attachment.sig>
