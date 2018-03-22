From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 22 Mar 2018 13:19:06 +0100
Subject: v4.16-rc5 on droid4: external abort in l2c310_configure+0x38/0x160
In-Reply-To: <20180322120359.GA12518@amd>
References: <20180322120359.GA12518@amd>
Message-ID: <20180322121906.GC12518@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2018-03-22 13:03:59, Pavel Machek wrote:
> Hi!
> 
> I'm trying to get something to work on Droid 4.
> 
> So far, v4.14 from leste project works, with the right config. I tried
> v4.16-rc5 next, and am stopped in early boot by:
> 
> If someone knows what this is let me know, but I guess it is
> config-dependend and I'll just try different one...

With different config it works, I just get storm of

^@^??r??????musb-hdrc musb-hdrc.1.auto: VBUS Disconnect

[   39.985656] musb-hdrc musb-hdrc.1.auto: VBUS b_idle, devctl 80

^@^??r????????musb-hdrc musb-hdrc.1.auto: VBUS Disconnect

[   40.005645] musb-hdrc musb-hdrc.1.auto: VBUS b_idle, devctl 80

^@^??r????????musb-hdrc musb-hdrc.1.auto: VBUS Disconnect

[   40.035766] musb-hdrc musb-hdrc.1.auto: VBUS b_idle, devctl 80



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/17c74a28/attachment.sig>
