From: b32955@freescale.com (Huang Shijie)
Date: Wed, 4 Sep 2013 10:16:09 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1377828449-18912-1-git-send-email-b32955@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
Message-ID: <522697E9.1050208@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?30? 10:07, Huang Shijie ??:
> (0) What is the Quadspi controller?
>
>     The Quadspi(Quad Serial Peripheral Interface) acts as an interface to
>     one single or two external serial flash devices, each with up to 4
>     bidirectional data lines.
>
Hi Mark:

Since this quadspi driver depends on the mtd code, could this driver
goes to the kernel by
the l2-mtd tree?


thanks
Huang Shijie
