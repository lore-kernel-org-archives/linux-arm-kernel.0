From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 17:56:25 +0000
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <CA+gwMcd+oMUpd2kNCVP4ojsKJtPwCXMgA2RsHT0+=p347n3ODw@mail.gmail.com>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
 <1392045139.6687.31.camel@pizza.hi.pengutronix.de>
 <20140210151821.GY26684@n2100.arm.linux.org.uk>
 <CA+gwMcd+oMUpd2kNCVP4ojsKJtPwCXMgA2RsHT0+=p347n3ODw@mail.gmail.com>
Message-ID: <20140210175625.GF26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 06:37:26PM +0100, Philipp Zabel wrote:
> I'd like all of them to go through, too. If you don't want to have the DT
> changes integrated, I'd appreciate if you could have a  look at my
> patches on top of your series and possibly append them to your
> series or let me synchronize somehow:
> 
> http://archive.arm.linux.org.uk/lurker/message/20140106.145159.a1d82ba9.en.html

I replied to your 2nd patch there...

I'm not happy ending up with a hard dependency between v4l2 code and
code needed for the display side to work, especially when we can end
up with imx-drm being the primary console display.  I've outlined my
thoughts about what I think needs to happen in the reply to patch 2.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
