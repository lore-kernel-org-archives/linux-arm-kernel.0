From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 13 Oct 2010 11:28:15 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <20101013082930.GA11286@pengutronix.de> (Wolfram Sang's message
	of "Wed\, 13 Oct 2010 10\:29\:30 +0200")
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>
	<20101013082930.GA11286@pengutronix.de>
Message-ID: <8762x6xx00.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> On Wed, Oct 13, 2010 at 10:15:04AM +0200, Eric B?nard wrote:
>
>> >I've tried it on a efika mx (to2 version) and I've a problem with the
>> >write-protect. It's on a GPIO and I don't see any way to configure the
>> >esdhc-imx driver to use it. Any idea on how it should be done ?
>> >
>> it's actually not yet supported by the driver. There is a wp_gpio in
>> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
>> but it's not yet used by the driver.
>
> It's all prepared. I finally will have a look into it today.

oh, great. I was thinking about doing it but I'll wait for your patches
then. I'm sure I need support for WP on GPIO but I may also need support
for CD on GPIO so I'll be happy to test any patch you have.


Thanks,
Arnaud
