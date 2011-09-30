From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 30 Sep 2011 15:58:45 +0200
Subject: [PATCH] arm/imx: rename MX51_MXC_INT_ATA to MX51_INT_ATA
In-Reply-To: <1317384355-24481-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Fri, 30 Sep 2011 20:05:55 +0800")
References: <1317384355-24481-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <87mxdmku7e.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

[ adding Uwe Kleine-Koning in CC: ]

Hi,

> This change is to fix the compile error below.
>
>   CC      arch/arm/plat-mxc/devices/platform-pata_imx.o
> arch/arm/plat-mxc/devices/platform-pata_imx.c:33:1: error: ?MX51_INT_ATA? undeclared here (not in a function)
> make[3]: *** [arch/arm/plat-mxc/devices/platform-pata_imx.o] Error 1

It's weird. All interrupt are supposed to be like MX51_INT_*. At least
it does on the old checkout from Sascha's tree here.

The renaming comes from
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/059666.html
which afaik has been merged.

Arnaud
