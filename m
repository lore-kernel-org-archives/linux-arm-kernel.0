From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 08 Jun 2010 11:16:37 +0900 (JST)
Subject: Current menuconfig (ARM system type) is broken
Message-ID: <w3pfx0yuv3x.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear all

Is current menuconfig broken ?
It mean

[Sytem Type] - [ARM system type]

In my environment, string output is broken.

I think 
${LINUX}/arch/arm/Kconfig

config ARCH_S3C2410
	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443, S3C2450"

this line is very long.
If I modify it to more short, it works correct.

Best regards
--
Kuninori Morimoto
 
