From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 20 Nov 2014 13:46:15 +0100
Subject: [PATCH] ARM: at91: remove useless init_time for DT-only SoCs
In-Reply-To: <201411192323.34609.arnd@arndb.de>
References: <1415604709-24185-1-git-send-email-boris.brezillon@free-electrons.com>
 <201411192323.34609.arnd@arndb.de>
Message-ID: <20141120134615.0ebb3b83@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 19 Nov 2014 23:23:34 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 10 November 2014, Boris Brezillon wrote:
> > Hi Olof,
> > 
> > You recently pulled some changes on Nicolas' at91-cleanup tag and two of
> > those commits (see above for commit hashes) are actually introducing
> > compilation errors.
> > This patch fixes those compilation errors.
> > 
> 
> Applied on next/cleanup, thanks!

Actually, I've made a v2 of this patch (see [1]) after realizing Olof
had already fixed the initial compilation error.
This is pretty much the same patch, except it removes asm/irq.h
inclusion.

[1]http://thread.gmane.org/gmane.linux.ports.arm.kernel/370398

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
