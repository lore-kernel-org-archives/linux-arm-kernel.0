From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 10 Apr 2011 22:02:03 -0400 (EDT)
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1104102157440.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Apr 2011, Uwe Kleine-K?nig wrote:

> The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
> compile a single (working) kernel for these.

Really?

Have a look at CONFIG_ARM_PATCH_PHYS_VIRT.  It's in mainline and fully 
functional.


Nicolas
