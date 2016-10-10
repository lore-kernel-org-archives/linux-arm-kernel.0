From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 10 Oct 2016 11:11:55 +0200
Subject: camera on n900, v4.8
In-Reply-To: <20161010084859.GD4467@pali>
References: <20161005190340.GA25755@amd>
 <20161010084859.GD4467@pali>
Message-ID: <20161010091155.GC7597@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-10-10 10:48:59, Pali Roh?r wrote:
> On Wednesday 05 October 2016 21:03:41 Pavel Machek wrote:
> > Hi!
> > 
> > Camera has some non-trivial dependencies on N900; it seems to rely on
> > gpio-switch.c, for example. I'll try to strip the diff further, but in
> > the meantime, here's the version I'm working with.
> > 
> 
> With "Camera" do you mean some Maemo userspace application? Because I
> think that nobody else could depends on gpio-switch kernel driver.

With camera, I mean kernel drivers for /dev/video*. I don't know why
they depend on gpio-switch.c, but they do.

I'm using fcam-dev for userspace control of camera. I'd prefer not to
touch anything w/o sources.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161010/1f4c86e0/attachment.sig>
