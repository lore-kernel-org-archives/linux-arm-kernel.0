From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 13 Oct 2010 00:06:23 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Mon\, 11 Oct 2010 16\:21\:00 +0200")
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <87aamjxe00.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> Here is the hopefully final (famous last words) version of my patch series. The
> first four are still updates/improvements for sdhci and sdhci-pltfm and are of
> generic interest, too. Thanks to Eric for the tests on MX25/35. Looking forward
> to comments/applied-to-mmc-next-messages ;)
>
> The series is based on mmc-next as of today and also available at
>
> 	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

I've tried it on a efika mx (to2 version) and I've a problem with the
write-protect. It's on a GPIO and I don't see any way to configure the
esdhc-imx driver to use it. Any idea on how it should be done ?


thanks,
Arnaud
