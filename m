From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 12:01:35 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1441709778.13536.8.camel@pengutronix.de>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
Message-ID: <20150908110135.GW21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 12:56:18PM +0200, Lucas Stach wrote:
> This is expected, it's the overlay adapter which doesn't really work
> with imx-drm yet.

No, it's imx-drm which isn't working.  As I explained in my previous
email, overlay planes are expected to do scaling.  imx-drm errors out
attempts for that.  This is a kernel bug, not an Xorg driver bug.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
