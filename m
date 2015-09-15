From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Sep 2015 17:36:42 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1442332425.2637.16.camel@pengutronix.de>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl>
 <1442332425.2637.16.camel@pengutronix.de>
Message-ID: <20150915163642.GW21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 05:53:45PM +0200, Lucas Stach wrote:
> It includes a new kernel<->userspace interface, so needs a modified
> xf86-video-armada to go with it. You can pick that up here:
> git://git.pengutronix.de/git/lst/xf86-video-armada.git for-rmk
> 
> Caution: the armada code is WIP and needs further cleanups. It should
> work though.

And it needs updating to the latest version - you seem to be missing
a whole load of changes, including the changes which update the
kernel API.

So... you seem to be talking about the kernel API having changed from
the version which you picked up years ago, rather than the current
version.  It's really unclear what you're talking about.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
