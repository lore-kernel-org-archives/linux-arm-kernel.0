From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 15 Oct 2010 12:25:34 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <8762x6xx00.fsf@lechat.rtp-net.org>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>
	<20101013082930.GA11286@pengutronix.de>
	<8762x6xx00.fsf@lechat.rtp-net.org>
Message-ID: <20101015102534.GA4276@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 11:28:15AM +0200, Arnaud Patard wrote:

> >> it's actually not yet supported by the driver. There is a wp_gpio in
> >> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
> >> but it's not yet used by the driver.
> >
> > It's all prepared. I finally will have a look into it today.
> 
> oh, great. I was thinking about doing it but I'll wait for your patches
> then. I'm sure I need support for WP on GPIO but I may also need support
> for CD on GPIO so I'll be happy to test any patch you have.

Just to keep you updated: Got a bit distracted again but I hope to
finish it on Saturday. Looks like a patch for the gpiolib is also
needed...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101015/e8fb7eaf/attachment.sig>
