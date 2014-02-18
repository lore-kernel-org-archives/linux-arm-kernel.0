From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 12:36:24 +0000
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <1392723909.3606.25.camel@pizza.hi.pengutronix.de>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
 <1392045139.6687.31.camel@pizza.hi.pengutronix.de>
 <20140210151821.GY26684@n2100.arm.linux.org.uk>
 <CA+gwMcd+oMUpd2kNCVP4ojsKJtPwCXMgA2RsHT0+=p347n3ODw@mail.gmail.com>
 <20140210175625.GF26684@n2100.arm.linux.org.uk>
 <1392723909.3606.25.camel@pizza.hi.pengutronix.de>
Message-ID: <20140218123624.GB21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 12:45:09PM +0100, Philipp Zabel wrote:
> Thanks for your comments there. I have just updated and resent this
> series ([RFC PATCH v3 0/9] imx-drm dt bindings), still with a temporary
> local copy of the v4l2_of functions, as long as the final resting place
> of the v4l2_of/of_graph functions seems to be a matter of discussion.

Okay.  My plans are to send more of these patches imminently to Greg.
I've just pulled them forward to -rc3, which means that four have now
dropped out of the series (as three have been recently merged and one
due to that build fix for imx-hdmi.)

I'm just debating whether I need to send the whole series out again or
not before doing that... any opinion?

Nothing's really changed in the patch set since the last time.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
