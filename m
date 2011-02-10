From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 10 Feb 2011 10:22:32 +0100
Subject: [PATCH] i.MX23/28 framebuffer driver
In-Reply-To: <20110209153716.GN9041@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091547.12131.arnd@arndb.de>
	<20110209153716.GN9041@pengutronix.de>
Message-ID: <20110210092232.GA4894@vixen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Feb 09, 2011 at 04:37:16PM +0100, ext Sascha Hauer wrote:
> Hi Arnd,
> 
> On Wed, Feb 09, 2011 at 03:47:11PM +0100, Arnd Bergmann wrote:
> > 
> > Did you consider making the driver a KMS driver instead of
> > a frame buffer? I think the recommendation these days is
> > to start out with KMS for new drivers, which will be somewhat
> > simpler and give you a frame buffer device as well. I don't
> > think that there is a need to change over any drivers from
> > fb to kms though, since you've already done the work.
> 
> I tried doing so for the i.MX51 which supports multiple displays on dvi
> and vga outputs and thus could make good use of KMS and friends. Anyway,
> I got stuck quite fast. The KMS stuff is tightly coupled with DRM/DRI
> and needs many many callbacks to implement. Additionally the userspace
> tools expect a nvidia/amd/intel driver and do not have a generic
> fallback. I think this stuff is good for implementing a full blown
> graphics driver, but is lacking support for simple framebuffer grapics.
> I'd love to go this way but it still requires a lot of work.

I will get the i.MX28 EVK within a couple of weeks. I'm curious of KMS,
which I don't know at all, and I would like to work on it. We could
join the efforts. What do you think?

Best regards,
Domenico
