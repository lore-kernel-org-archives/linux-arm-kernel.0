From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Aug 2018 22:26:39 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180716075926.GU99251@atomide.com>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd> <20180716075926.GU99251@atomide.com>
Message-ID: <20180801202639.GA4033@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-07-16 00:59:26, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180715 20:20]:
> > Yep, so I have two patches that make the device appear, but vibrations
> > still do not work for me.
> > 
> > a) any ideas how to debug that / get them to work?
> 
> Hmm no new ideas except I wonder if there is also some other
> regression with the timer pdata not being passed properly now.

Got it, pinmux part of dts was at wrong place, too. Patch will follow.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/4b9bc8f6/attachment.sig>
