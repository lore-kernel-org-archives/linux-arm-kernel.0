From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Oct 2010 10:29:30 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <4CB56A88.2040101@eukrea.com>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>
Message-ID: <20101013082930.GA11286@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 10:15:04AM +0200, Eric B?nard wrote:

> >I've tried it on a efika mx (to2 version) and I've a problem with the
> >write-protect. It's on a GPIO and I don't see any way to configure the
> >esdhc-imx driver to use it. Any idea on how it should be done ?
> >
> it's actually not yet supported by the driver. There is a wp_gpio in
> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
> but it's not yet used by the driver.

It's all prepared. I finally will have a look into it today.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101013/55c7b3f3/attachment.sig>
