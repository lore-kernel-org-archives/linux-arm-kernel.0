From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Jun 2010 11:25:49 +0900
Subject: Current menuconfig (ARM system type) is broken
In-Reply-To: <w3pfx0yuv3x.wl%kuninori.morimoto.gx@renesas.com>
References: <w3pfx0yuv3x.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <00cc01cb077b$16333e60$4299bb20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kuninori Morimoto wrote:
> 
> Dear all
> 
Hi,

> Is current menuconfig broken ?
> It mean
> 
> [Sytem Type] - [ARM system type]
> 
> In my environment, string output is broken.
> 
> I think
> ${LINUX}/arch/arm/Kconfig
> 
> config ARCH_S3C2410
> 	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440,
> S3C2442, S3C2443, S3C2450"
> 
> this line is very long.
> If I modify it to more short, it works correct.
> 

It was already reported.

Please refer to below thread.

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017001.html

Ben Dooks' comments:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017030.html


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
