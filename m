From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 6 Apr 2017 20:13:18 +0200
Subject: N900 failure in next-20170321
In-Reply-To: <20170321153851.GA10760@atomide.com>
References: <20170321135708.GA22358@amd> <20170321153851.GA10760@atomide.com>
Message-ID: <20170406181318.GE10363@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-03-21 08:38:52, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [170321 06:59]:
> > Hi!
> > 
> > Tony asked me to test linux-next from time to time. I did... today I
> > moved from next-20170309 to next-20170321. Kernel boots and seems to
> > work fine (including audio and X startup), but if I leave it sitting
> > for a while RGB LED reverts from "system alive" to charging indication
> > that was disabled before and system does not react to any input.
> > 
> > Any ideas?
> 
> Not much there I could see affecting this.. Try reverting commit
> 179125085bd4 ("ARM: OMAP3: Fix smartreflex platform data regression")?
> 
> Maybe smartreflex now attempts to do something but we're missing
> or have wrong dts configuration for n900?

I tried today's next, and it did not hang for a few hours. So I guess
problem is gone now.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/b9d9203a/attachment.sig>
