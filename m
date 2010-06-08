From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 8 Jun 2010 04:35:17 +0200
Subject: Current menuconfig (ARM system type) is broken
In-Reply-To: <w3pfx0yuv3x.wl%kuninori.morimoto.gx@renesas.com>
References: <w3pfx0yuv3x.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <201006080435.17113.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervna 2010 04:16:37 Kuninori Morimoto napsal(a):
> Dear all
> 
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
> 	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442,
> S3C2443, S3C2450"
> 
> this line is very long.
> If I modify it to more short, it works correct.

hey, this was discussed here not long ago, look for:

[PATCH 2/2] menuconfig: truncate list items
> 
> Best regards
> --
> Kuninori Morimoto
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
