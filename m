From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Dec 2017 11:16:51 +0100
Subject: linux-next on Nokia N900: hang on boot
In-Reply-To: <20171202111954.4gg43xkb2wf5ebmn@pali>
References: <20171202101456.GA1810@amd> <20171202111954.4gg43xkb2wf5ebmn@pali>
Message-ID: <20171207101651.GA23691@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2017-12-02 12:19:54, Pali Roh?r wrote:
> On Saturday 02 December 2017 11:14:56 Pavel Machek wrote:
> > Hi!
> > 
> > next from 2017-12-01 was tested.
> > 
> > MMC is detected, but then I see wtl4030_bci: .. battery temperature
> > out of range, and machine halts. This is just before userspace would
> > be started.
> > 
> > 4.15-rc1 seems to work ok on the box.
> > 
> > Any ideas?
> 
> twl4030_bci is not available on Nokia N900, so we should not try to read
> its registers.

Today's git boots on N900; good. What is going on with twl4030_bci I
don't have time to investigate at the moment.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/f2ced812/attachment.sig>
