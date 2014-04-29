From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Apr 2014 12:09:50 +0100
Subject: [PATCH v2 0/7] Generic serial earlycon
In-Reply-To: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140429110950.GF17007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 11:19:53PM +0100, Rob Herring wrote:
> Rob Herring (7):
>   x86: move FIX_EARLYCON_MEM kconfig into x86
>   tty/serial: add generic serial earlycon
>   tty/serial: convert 8250 to generic earlycon
>   tty/serial: pl011: add generic earlycon support
>   tty/serial: add arm/arm64 semihosting earlycon
>   arm64: enable FIX_EARLYCON_MEM kconfig
>   arm64: remove arch specific earlyprintk

The series looks fine, you can add:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

BTW, are you merging all of them via some other tree or would prefer me
to take the arm64-specific patches?
