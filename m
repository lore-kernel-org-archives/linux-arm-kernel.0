From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 14:17:52 +0100
Subject: [PATCH] ARM: at91: remove useless init_time for DT-only SoCs
In-Reply-To: <20141120134615.0ebb3b83@bbrezillon>
References: <1415604709-24185-1-git-send-email-boris.brezillon@free-electrons.com>
 <201411192323.34609.arnd@arndb.de> <20141120134615.0ebb3b83@bbrezillon>
Message-ID: <3067112.uVqLBI6L6W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 13:46:15 Boris Brezillon wrote:
> Actually, I've made a v2 of this patch (see [1]) after realizing Olof
> had already fixed the initial compilation error.
> This is pretty much the same patch, except it removes asm/irq.h
> inclusion.
> 
> [1]http://thread.gmane.org/gmane.linux.ports.arm.kernel/370398
> 

Sorry about this. Do you want to send an add-on patch to change that one
line, or should we just keep the current version?

	Arnd
