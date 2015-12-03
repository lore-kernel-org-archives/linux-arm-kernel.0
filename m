From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 3 Dec 2015 16:23:20 +0800
Subject: [PATCH 5/7] ARM: w90x900: make headers more local
In-Reply-To: <1448924458-3279040-6-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
 <1448924458-3279040-6-git-send-email-arnd@arndb.de>
Message-ID: <CAKT61h-_rpT0O06ruUbtUPj2FPf57gLpWhyUKE-zFdVpCDg-yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-01 7:00 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> Some header files are never included outside of a mach-w90x900
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Wan Zongshun <mcuos.com@gmail.com>

Thanks!

> ---
>  arch/arm/mach-w90x900/cpu.c                           | 4 ++--
>  arch/arm/mach-w90x900/{include/mach => }/regs-ebi.h   | 0
>  arch/arm/mach-w90x900/{include/mach => }/regs-gcr.h   | 0
>  arch/arm/mach-w90x900/{include/mach => }/regs-timer.h | 0
