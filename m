From: post@hendrik-sattler.de (Hendrik Sattler)
Date: Wed, 9 Jun 2010 08:07:20 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <4C0ED074.7050700@bluewatersys.com>
References: <4C083BCF.2060500@bluewatersys.com>
	<alpine.LFD.2.00.1006081655350.30664@xanadu.home>
	<4C0ED074.7050700@bluewatersys.com>
Message-ID: <201006090807.20810.post@hendrik-sattler.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 09 Juni 2010, 01:21:24 schrieb Ryan Mallon:
> Yes. I thought the problem was that Kconfig doesn't work correctly for
> this though. Does having 'select MTD_PARTITIONS' automatically cause
> CONFIG_MTD to be set? If not, then you basically need to have the full
> config option list, which is basically what defconfig is.

Anybody thought about improving Kconfig to make this possible?
Specifying CONFIG_MTD and CONFIG_MTD_PARTITIONS again and again will just 
repeat information (that CONFIG_MTD_PARTITIONS depends on CONFIG_MTD).
The recursive 'select' could have a different name.

HS
