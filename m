From: peter.ujfalusi@ti.com (=?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?=)
Date: Tue, 09 Oct 2012 11:03:10 +0200
Subject: [PATCH 1/2] ARM: OMAP: Trivial driver changes to remove include
 plat/cpu.h
In-Reply-To: <20121008173557.10603.18539.stgit@muffinssi>
References: <20121008173452.10603.53886.stgit@muffinssi>
 <20121008173557.10603.18539.stgit@muffinssi>
Message-ID: <5073E84E.4090408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 07:35 PM, Tony Lindgren wrote:

> - omap-dma.c and omap-pcm.c can test the arch locally as
>   omap1 and omap2 cannot be compiled together because of
>   conflicting compiler flags

>  sound/soc/omap/omap-pcm.c         |    9 +++++++--

Tony: is this going to be included in 3.7?

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
