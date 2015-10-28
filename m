From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 12:39:43 +0300
Subject: [PATCH v2 1/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <563095BE.9050106@samsung.com>
References: <cover.1445935215.git.p.fedin@samsung.com>
 <91ae80f172192fa4dbc8bf8ee5a9068661592de6.1445935215.git.p.fedin@samsung.com>
 <56302F1F.5090206@samsung.com> <009001d1114f$3c7a1f60$b56e5e20$@samsung.com>
 <56307824.1050302@samsung.com> <563095BE.9050106@samsung.com>
Message-ID: <003101d11164$93c83b70$bb58b250$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> There is no offset such as SROM_BC{4,5} at least in these SoC
> manuals. Accordingly I modified size from 0x100 to 0x10.

 0x10 is indeed an offset for SROM_BC3. But, it occupies 4 bytes by itself, and you have to include it, because you are describing
*SIZE* of the region. :)

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
