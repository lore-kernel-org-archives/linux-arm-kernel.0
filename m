From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 19:29:28 +0000
Subject: [PATCH 1/2] ARM: clps711x: Cleanup IRQ handling
In-Reply-To: <1337104502-5292-2-git-send-email-shc_work@mail.ru>
References: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
 <1337104502-5292-2-git-send-email-shc_work@mail.ru>
Message-ID: <201205151929.28324.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Alexander Shiyan wrote:
> This patch contains two changes:
> - Removed unused definitions from mach/irqs.h
> - Do not mask interrupts in ack procedure, because we have separate
>   intX_mask procedure for do it and actually these 2 functions are
>   called sequentially
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, and pulled it with the other cleanup into the next/cleanup branch.

Thanks,

	Arnd
