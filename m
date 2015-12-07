From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 7 Dec 2015 16:24:00 +0100 (CET)
Subject: [PATCH 06/10] ARM: debug-ll: rework gemini handling
In-Reply-To: <1449268242-808553-7-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-7-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LNX.2.00.1512071623280.14799@T520.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Dec 2015, Arnd Bergmann wrote:

> Gemini can not yet be configured in a multiplatform kernel, but
> if we ever get there, enabling one of the gemini platforms
> while trying to use DEBUG_LL for another platform can default to
> the wrong UART address, as the options are purely based on the
> architecture being enabled or not.
> 
> This changes the logic to use the gemini default addresses and
> the flow control settings only if we have also picked the respective
> Kconfig symbols introduced here.
> 
> While we're at it, this also reorders the virtual address as
> it should be.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
