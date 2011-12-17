From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Dec 2011 21:18:25 +0100
Subject: [PATCHv2 0/5] Misc picoxcell updates for 3.3
In-Reply-To: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
References: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
Message-ID: <18144957.3Nv7HuJyz7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 December 2011 13:42:32 Jamie Iles wrote:
> Here's v2 of a small series of feature updates for picoxcell in 3.3.
> 
> Jamie
> 
> Jamie Iles (5):
>   ARM: picoxcell: remove mach/memory.h
>   ARM: picoxcell: don't reserve irq_descs
>   ARM: picoxcell: move io mappings to common.c
>   MAINTAINERS: add maintainer entry for Picochip picoxcell
>   ARM: picoxcell: implement watchdog restart

Hi Jamie,

The series looks good to me, aside from the trivial comments I've given
on patch 5. When you submit these for inclusion in arm-soc, please split
the series so that the first four patches can go into the next/cleanup
branch, while the last patch goes into the devel branch.

	Arnd
