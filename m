From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 11:10:37 +0000
Subject: [alsa-devel] [PATCH 03/12] add a mc13783 codec driver
In-Reply-To: <20091125110854.GC27548@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
	<20091125074631.GB27548@pengutronix.de>
	<20091125103959.GB17420@opensource.wolfsonmicro.com>
	<20091125110854.GC27548@pengutronix.de>
Message-ID: <20091125111037.GE17420@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 12:08:54PM +0100, Sascha Hauer wrote:
> On Wed, Nov 25, 2009 at 10:39:59AM +0000, Mark Brown wrote:

> > What are "primary" and "secondary" here?  If they are broadly unrelated
> > except for the clocking (which is what this sounds like) then they
> > probably should be handled as separate DAIs.

> I thought about this, but can I do stereo with two seperate DAIs?

Again, what are "primary" and "secondary"?
