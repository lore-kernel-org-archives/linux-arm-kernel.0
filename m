From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 14:35:44 +0000
Subject: [PATCH v2 0/5] Use more asm-generic headers
In-Reply-To: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
Message-ID: <201208061435.44216.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 August 2012, Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Inspired by the AArgh64 claim that it should be separate from ARM and one
> reason was being able to use more asm-generic headers. Doing a diff of
> arch/arm/include/asm and include/asm-generic there are numerous asm
> headers which are functionally identical to their asm-generic counterparts
> and others which can use more of the generic versions.
> 
> V2 separates unaligned.h and termios.h changes to separate patches. Also,
> it adds a fix for build failures on non-gzip decompressor compile.
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
