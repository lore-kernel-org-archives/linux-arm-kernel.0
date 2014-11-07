From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Nov 2014 14:45:10 +0100
Subject: [PATCH v2 01/11] mfd: syscon: Add atmel-matrix registers
 definition
In-Reply-To: <1415203287-21517-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141107134510.GC4068@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2014 at 17:01:17 +0100, Boris Brezillon wrote :
> AT91 SoCs have a memory range reserved for internal bus configuration.
> Expose those registers so that drivers can make use of the matrix syscon
> declared in at91 DTs.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/mfd/syscon/atmel-matrix.h | 114 ++++++++++++++++++++++++++++++++

I think we should stop cluttering the include/linux directory and start
doing what has been done for tegra and create an include/soc/atmel or
include/soc/at91 directory. that's what I was planning to do in my
sdramc/reset series but I didn't get any comment on it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
