From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 5 Aug 2012 11:34:21 +0200
Subject: [PATCH v2 0/5] Use more asm-generic headers
In-Reply-To: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120805113421.57401d21@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sat,  4 Aug 2012 20:23:55 -0500,
Rob Herring <robherring2@gmail.com> a ?crit :

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Inspired by the AArgh64 claim that it should be separate from ARM and
> one reason was being able to use more asm-generic headers. Doing a
> diff of arch/arm/include/asm and include/asm-generic there are
> numerous asm headers which are functionally identical to their
> asm-generic counterparts and others which can use more of the generic
> versions.
> 
> V2 separates unaligned.h and termios.h changes to separate patches.
> Also, it adds a fix for build failures on non-gzip decompressor
> compile.
> 
> Rob
> 
> Rob Herring (5):
>   ARM: use generic version of identical asm headers
>   ARM: add strstr declaration for decompressors
>   ARM: use generic unaligned.h
>   ARM: use generic termios.h
>   ARM: convert asm/irqflags.h to use asm-generic/irqflags.h

Built and boot tested on Armada XP evaluation platform.

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
