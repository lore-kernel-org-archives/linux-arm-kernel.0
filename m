From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Apr 2012 16:20:49 +0100
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <20120420151518.GR3852@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
 <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
 <20120420123842.GA25662@avionic-0098.adnet.avionic-design.de>
 <20120420142558.GB20681@sirena.org.uk>
 <20120420151518.GR3852@pengutronix.de>
Message-ID: <20120420152048.GC6828@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 05:15:18PM +0200, Sascha Hauer wrote:
> On Fri, Apr 20, 2012 at 03:25:58PM +0100, Mark Brown wrote:

> > This sounds an awful lot like how ASoC hangs together...

> Very much, yes. In ASoC and DRM we both have several physical devices spread
> around the SoC which form a logical device. I assume that before ASoC existed
> also everyone had a single PCI device which could be used to collect the
> information together.

Yeah, it's a similar issue - on PC hardware we tend to have a single
integrated device which does everything (at least from the point of view
of the outside world, physically things may sometimes be split).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/61d9507c/attachment.sig>
