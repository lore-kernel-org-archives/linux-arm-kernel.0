From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 21:58:47 +0200
Subject: [PATCH v8 16/16] MAINTAINERS: Add entry for STM32 MCUs
In-Reply-To: <1431158038-3813-17-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-17-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <2293841.j2iIvBlO19@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 May 2015 09:53:58 Maxime Coquelin wrote:
> Add a MAINTAINER entry covering all STM32 machine and drivers files.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e5bbc0..858d821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1479,6 +1479,14 @@ F:	drivers/usb/host/ehci-st.c
>  F:	drivers/usb/host/ohci-st.c
>  F:	drivers/ata/ahci_st.c
>  
> +ARM/STM32 ARCHITECTURE
> +M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
> +N:	stm32
> +F:	drivers/clocksource/armv7m_systick.c
> +
>  ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> 

Applied to next/soc, thanks!

	Arnd
